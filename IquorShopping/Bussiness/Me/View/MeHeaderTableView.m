//
//  MeHeaderTableView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeHeaderTableView.h"
#import "MeInfoViewController.h"
#import "UIControl+IquorArea.h"
#import "MeCollectionCell.h"
#import "VIPLevelViewController.h"
#import "PayKindViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import "WechatOrder.h"
@interface MeHeaderTableView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSInteger cor;
}
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *startLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *nikeName;
@property (weak, nonatomic) IBOutlet UILabel *vipDes;
@property (weak, nonatomic) IBOutlet UILabel *agentDes;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;
@property (weak, nonatomic) IBOutlet UIButton *meInfoBtn;
@property (nonatomic, strong) NSMutableArray *arrs;


@end
@implementation MeHeaderTableView

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.layer.borderColor = [UIColor redColor].CGColor;
//    self.layer.borderWidth = 1;
    self.userHeader.layer.cornerRadius = 32;
    self.userHeader.clipsToBounds = YES;
    [self.meInfoBtn setEnlargeEdge:20];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 0);
    flowLayout.itemSize = CGSizeMake(kMainScreenWidth-80, 60);
    self.collectionView.collectionViewLayout = flowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"MeCollectionCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MeCollectionCell class])];
    
}
- (NSString *)getVIPLever:(NSInteger)lever {
    return [NSString stringWithFormat:@"%ld级会员", (long)lever];
}
- (void)setIsfresh:(BOOL)isfresh {
    _isfresh = isfresh;
    IQourUser *user = [IQourUser shareInstance];
    if (![UIUtils isNullOrEmpty:user.user_tel]) {
        self.startLoginBtn.hidden = YES;
        self.vipDes.hidden = NO;
        self.nikeName.hidden = NO;
        self.agentDes.hidden = NO;
        self.nikeName.text = user.nick_name;
        [self.userHeader sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"icon_head_01"]];
        self.vipDes.text = [NSString stringWithFormat:@"会员级别：%@", user.level_name];
        if (user.level.intValue <= 3) {
            cor = 2;
            self.collectionView.hidden = NO;
        }else if (user.level.intValue == 4) {
            cor = 1;
            self.collectionView.hidden = NO;
        }else {
            cor = 0;
            self.collectionView.hidden = YES;
        }
        [self.collectionView reloadData];
        
    }else {
        self.startLoginBtn.hidden = NO;
        self.nikeName.hidden = YES;
        self.vipDes.hidden = YES;
        self.agentDes.hidden = YES;
    }
   
    
    if ([UIUtils isNullOrEmpty:user.user_tel]) {
        self.collectionView.hidden = YES;
    }
    
}
- (IBAction)loginClick:(id)sender {
    if (self.clickButtonBlock) {
        self.clickButtonBlock(KLogin);
    }
//    UIButton *btn = (UIButton *)sender;
//    btn.selected = !btn.selected;
//    self.heightLayout.constant = btn.selected ? 0 : 60;
}
- (IBAction)joinClick:(id)sender {
    if (self.clickButtonBlock && [IQourUser shareInstance].user_tel) {
        self.clickButtonBlock(KJoin);
    }else {
        self.clickButtonBlock(KLogin);
    }
}
- (IBAction)infoClick:(id)sender {
    if (self.clickButtonBlock  && [IQourUser shareInstance].user_tel) {
        self.clickButtonBlock(KMeInfo);
    }else {
        self.clickButtonBlock(KLogin);
    }
}
- (void)startOrder:(NSString *)type {
   
        NSDictionary *param = @{@"pay_type":type, @"pay_scene":@"2"};
        @weakify(self);
        [AFNetworkTool postJSONWithUrl:pay_requestPayment parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                if (type.integerValue == 1) {
                    [self doAPPay:responseObject[@"content"]];
                }else if (type.integerValue == 2) {
                    [self doWeChat:[WechatOrder yy_modelWithDictionary:responseObject[@"content"]]];
                }else {
                    [Dialog popTextAnimation:@"支付成功"];
                }
            }else {
                [Dialog popTextAnimation:responseObject[@"message"]];
            }
        } fail:^{
            
        }];
}
- (void)doAPPay:(NSString *)orderString {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"com.elevation.IquorShopping" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}
- (void)doWeChat:(WechatOrder *)order {
    PayReq *request = [[PayReq alloc] init];
    
    request.partnerId = order.partnerid;
    
    request.prepayId= order.prepayid;
    
    request.package = order.package;
    
    request.nonceStr= order.noncestr;
    
    request.timeStamp= order.timestamp;
    
    request.sign= order.sign;
    [WXApi sendReq:request];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return cor;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MeCollectionCell class]) forIndexPath:indexPath];
    if (indexPath.item == 0 && cor == 2) {
        cell.title.text = @"加入会员  福利多多";
        cell.subTitle.text = @"不同会员等级享受不等的商品折扣";
        cell.container.backgroundColor = UIColorFromRGB(0xcbcbcb);
        
        cell.operatorCellBlock = ^{
            VIPLevelViewController *vc = [[VIPLevelViewController alloc]init];
            [NSObject.getCurrentVC.navigationController pushViewController:vc animated:YES];
        };
        
    }else {
        cell.title.text = @"成为经销商享受专属福利";
        cell.subTitle.text = @"成为经销商购物福利多多";
        [cell.operatorBtn setTitle:@"立即加盟" forState:UIControlStateNormal];
        [cell.operatorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.operatorBtn.backgroundColor = UIColorFromRGB(0xCD8946);
        cell.container.backgroundColor = UIColorFromRGB(0xd39b66);
        @weakify(self);
        cell.operatorCellBlock = ^{
            @strongify(self);
            PayKindViewController *vc = [[PayKindViewController alloc]init];
            vc.pay_scene = @"2";
            vc.operatorPayCellBlock = ^(NSString *type) {
                [self startOrder:type];
            };
            [NSObject.getCurrentVC.navigationController pushViewController:vc animated:YES];
        };
    }
    return cell;
}

- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

@end
