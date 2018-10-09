//
//  MechantInfoViewController.m
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MechantInfoViewController.h"
#import "SDCycleScrollView.h"
#import "SiginCell.h"
#import "MerchantModel.h"
#import "GoodsInfoModel.h"
#import "GoodsInfoViewController.h"

@interface MechantInfoViewController ()

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *merchantAvatar;
@property (weak, nonatomic) IBOutlet UILabel *merchantName;
@property (weak, nonatomic) IBOutlet UILabel *merchantAddr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;

@end

@implementation MechantInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.merchant.shop_name;
    
    [self configUI];
    self.page = 1;
    [self requestMerchantInfo];
    [self requestMerchantGoodsList];
    
}

- (void)configUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    CGFloat wh =(kMainScreenWidth-1)/2;
    flowLayout.itemSize = CGSizeMake(wh, wh);
    self.collectionView.collectionViewLayout = flowLayout;
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.arrs = nil;
        [self requestMerchantGoodsList];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestMerchantGoodsList];
    }];
}
- (void)requestMerchantGoodsList {
    NSDictionary *param = @{@"shop_id":self.merchant.shop_id, @"page":@(self.page)};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:merchant_goods_url parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[GoodsInfoModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
            }else {
                [Dialog popTextAnimation:self.page==1?@"暂无数据":@"没有下一页了"];
            }
            [self.collectionView setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:@"暂无数据"];
            [self.collectionView reloadData];
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}

- (void)requestMerchantInfo {
    NSDictionary *param = @{@"shop_id":self.merchant.shop_id};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:merchant_info_url parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            [self renderMerchant:[MerchantInfo yy_modelWithDictionary:responseObject[@"content"][@"welfare_shop_info"]]];
            
        }
    } fail:^{
        
    }];
}


- (void)renderMerchant:(MerchantInfo *)merchantInfo {
    [self.merchantAvatar sd_setImageWithURL:[NSURL URLWithString:merchantInfo.shop_image]];
    self.merchantName.text = merchantInfo.shop_name;
    self.merchantAddr.text = merchantInfo.shop_addr;
    self.cycleScrollView.imageURLStringsGroup = merchantInfo.shop_pics;
    self.cycleScrollView.autoScrollTimeInterval = 4;
    self.cycleScrollView.showPageControl = NO;
}

- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrs.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SiginCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SiginCell class]) forIndexPath:indexPath];
    [cell configGoodsInfo:self.arrs[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GoodsInfoViewController *vc = [[GoodsInfoViewController alloc]init];
    GoodsInfoModel *model = self.arrs[indexPath.item];
    vc.goods_id = model.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
