//
//  MeViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "MeInfoViewController.h"
#import "MeHeaderTableView.h"
#import "MeSectionTableView.h"
#import "MeConfigModel.h"
#import "MeCollectionReusableView.h"
#import "MePageCollectionViewCell.h"
#import "IndentViewController.h"
#import "LoginOperator.h"
@interface MeViewController ()< UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) MeHeaderTableView *configView;
@property (nonatomic, strong) MeConfigModel *configModel;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (@available(iOS 11.0, *)) {
//        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }


    [self.view addSubview:self.configView];
    [self.view addSubview:self.collectionView];
    [self.configView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.configView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self requestMeInfo];
    self.configView.isfresh = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//我的
- (void)requestMeInfo {
    [AFNetworkTool postJSONWithUrl:user_personCenter parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            IQourUser *user = [IQourUser shareInstance];
            user.uid = responseObject[@"content"][@"user_info"][@"uid"];
            user.level = responseObject[@"content"][@"user_info"][@"level"];
            user.level_name = responseObject[@"content"][@"user_info"][@"level_name"];
            user.service_number = responseObject[@"content"][@"set_contact"][@"service_number"];
            [[IQourUser shareInstance] save];
            
            [[NSUserDefaults standardUserDefaults] setObject:user.service_number forKey:@"severTel"];
            self.configView.isfresh = YES;
        }else {
            
        }
    } fail:^{
        
    }];
}
- (void)showAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您尚未登录，是否现在登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
      
        [[LoginOperator shareInstance] loginVC:^(BOOL isScu) {
            
        }];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)startContactService {
    NSString *telNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"severTel"];
    NSString *tel = [NSString stringWithFormat:@"tel:%@", telNum];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:tel]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    }
}
#pragma mark UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainScreenWidth, 50);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        MeCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([MeCollectionReusableView class]) forIndexPath:indexPath];
        if (indexPath.section == 0) {
            view.title.text = @"我的订单";
            view.button.hidden = NO;
            view.indicate.hidden = NO;
            @weakify(self);
            view.operatorCellBlock = ^{
                @strongify(self);
                IndentViewController *vc = [[IndentViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            };
        }else if (indexPath.section == 1) {
            view.title.text = @"代理中心";
        }else if (indexPath.section == 2) {
            view.title.text = @"我的服务";
        }
        return view;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _configModel.configModels.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arrs = _configModel.configModels[section];
    return arrs.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MePageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MePageCollectionViewCell class]) forIndexPath:indexPath];
    cell.cellModel = _configModel.configModels[indexPath.section][indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    MeConfigModel *cm = _configModel.configModels[indexPath.section][indexPath.item];
    if (![UIUtils isNullOrEmpty:cm.className]) {
        if (cm.className.intValue == 9) {
            //联系客服
            [self startContactService];
        }else {
            Class cls = NSClassFromString(cm.className);
            if (cm.need && [UIUtils isNullOrEmpty:[IQourUser shareInstance].user_tel]) {
                [self showAlert];
            }else {
                UIViewController *vc = [[cls alloc]init];
                if ([vc isKindOfClass:[IndentViewController class]]) {
                    IndentViewController *indentVC = (IndentViewController*)vc;
                    if ([cm.dec isEqualToString:@"待付款"]) {
                        indentVC.curIndex = 1;
                    }else if ([cm.dec isEqualToString:@"待发货"]) {
                        indentVC.curIndex = 2;
                    }else if ([cm.dec isEqualToString:@"待收货"]) {
                        indentVC.curIndex = 3;
                    }else if ([cm.dec isEqualToString:@"待评价"]) {
                        indentVC.curIndex = 4;
                    }
                    indentVC.title = cm.dec;
                    [self.navigationController pushViewController:indentVC animated:YES];
                }else {
                    vc.title = cm.dec;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
    }
}

#pragma mark set & get


- (MeHeaderTableView *)configView {
    if (!_configView) {
        _configView = [[[NSBundle mainBundle]loadNibNamed:@"MeHeaderTableView" owner:self options:nil] firstObject];
        @weakify(self);
        _configView.clickButtonBlock = ^(OperateType operate) {
            @strongify(self);
            if (operate == KLogin) {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }else if (operate == KJoin) {
                
            }else if (operate == KMeInfo) {
                MeInfoViewController *infoVC = [[MeInfoViewController alloc]init];
                [self.navigationController pushViewController:infoVC animated:YES];
            }
        };
    }
    return _configView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _configModel = [[MeConfigModel alloc]init];
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kMainScreenWidth/4, 100);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor c_f5f5Color];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"MePageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MePageCollectionViewCell class])];
        [_collectionView registerNib:[UINib nibWithNibName:@"MeCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([MeCollectionReusableView class])];
    }
    return _collectionView;
}
@end
