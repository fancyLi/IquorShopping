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
#import "MeConfigTableViewCell.h"
#import "MeHeaderTableView.h"
#import "MeSectionTableView.h"
#import "MeConfigModel.h"
#import "MeCollectionReusableView.h"
#import "MePageCollectionViewCell.h"
@interface MeViewController ()< UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) MeHeaderTableView *configView;
@property (nonatomic, strong) MeConfigModel *configModel;

@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }


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
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainScreenWidth, 50);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        MeCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([MeCollectionReusableView class]) forIndexPath:indexPath];
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
        Class cls = NSClassFromString(cm.className);
        UIViewController *vc = [[cls alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark set & get


- (MeHeaderTableView *)configView {
    if (!_configView) {
        _configView = [[[NSBundle mainBundle]loadNibNamed:@"MeHeaderTableView" owner:self options:nil] firstObject];
        WeakObj(self);
        _configView.clickButtonBlock = ^(OperateType operate) {
            if (operate == KLogin) {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [selfWeak.navigationController pushViewController:loginVC animated:YES];
            }else if (operate == KJoin) {
                
            }else if (operate == KMeInfo) {
                MeInfoViewController *infoVC = [[MeInfoViewController alloc]init];
                [selfWeak.navigationController pushViewController:infoVC animated:YES];
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
