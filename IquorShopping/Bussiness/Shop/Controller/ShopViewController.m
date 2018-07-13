//
//  ShopViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopDiscountViewController.h"
#import "PlayerViewController.h"
#import "SiginViewController.h"
#import "GoodsInfoViewController.h"
#import "ShopTableHeaderView.h"
#import "ShopConfigCell.h"
#import "ShopVideoCell.h"
#import "ShopHotCell.h"
#import "ShopNewCell.h"
#import "HomePageModel.h"
@interface ShopViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *shopTableView;
@property (nonatomic, strong) ShopTableHeaderView *tableHeader;
@property (nonatomic, strong) HomePageModel *homePageModel;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.shopTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self.view addSubview:self.shopTableView];
    self.shopTableView.tableHeaderView = self.tableHeader;
    [self requestHomePage];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
 
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)startPlayer {
    if ([UIUtils isNullOrEmpty:self.homePageModel.video.video_url]) {
        [Dialog popTextAnimation:@"暂无宣传视频"];
    }else {
        PlayerViewController *playerVC = [[PlayerViewController alloc]init];
        playerVC.viderStr = self.homePageModel.video.video_url;
        [self presentViewController:playerVC animated:YES completion:nil];
    }
}

- (void)requestHomePage {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:index_homePage parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.homePageModel = [HomePageModel yy_modelWithJSON:responseObject[@"content"]];
            self.tableHeader.banners = self.homePageModel.banner_list;
            [self.shopTableView reloadData];
            
        }else {
            
        }
    } fail:^{
        
    }];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
    }else if (indexPath.section == 1) {
        return 270;
    }else if (indexPath.section == 2) {
        return 270;
    }else {
        ShopNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopNewCell class])];
       return  [cell getCellHeight:self.homePageModel.goods_new];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakObj(self);
    if (indexPath.section == 0) {
        ShopConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopConfigCell class])];
        [cell configCatInfo:self.homePageModel.goods_cat_list];
        cell.configBlock = ^(ClassInfoModel *model) {
            if (model.cat_id.integerValue != 0) {
                SiginViewController *siginVC = [[SiginViewController alloc]init];
                siginVC.cat_id = model.cat_id;
                siginVC.cat_name = model.cat_name;
                [selfWeak.navigationController pushViewController:siginVC animated:YES];
            }else {
                if ([model.cat_name isEqualToString:@"领券"]) {
                    ShopDiscountViewController *vc = [[ShopDiscountViewController alloc]init];
                    [selfWeak.navigationController pushViewController:vc animated:YES];
                }else {
                    self.tabBarController.selectedIndex = 2;
                }
            }
            
        };
        return cell;
    }else if (indexPath.section == 1) {
        ShopVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopVideoCell class])];
        cell.video_img = self.homePageModel.video.video_img;
        return cell;
    }else if (indexPath.section == 2) {
        ShopHotCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopHotCell class])];
        [cell configHotInfo:self.homePageModel.hot_goods];
        @weakify(self);
        cell.operatorHotCellBlock = ^(GoodsInfoModel *model) {
            @strongify(self);
            GoodsInfoViewController *vc = [[GoodsInfoViewController alloc]init];
            vc.goods_id = model.goods_id;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.operatorHotLookBlock = ^{
            @strongify(self);
            SiginViewController *vc = [[SiginViewController alloc]init];
            vc.type = @"1";
            vc.title = @"热门推荐";
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else {
        ShopNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopNewCell class])];
        [cell configNewInfo:self.homePageModel.goods_new];
        @weakify(self);
        cell.operatorHotCellBlock = ^(GoodsInfoModel *model) {
            @strongify(self);
            GoodsInfoViewController *vc = [[GoodsInfoViewController alloc]init];
            vc.goods_id = model.goods_id;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.operatorHotLookBlock = ^{
            @strongify(self);
            SiginViewController *vc = [[SiginViewController alloc]init];
            vc.type = @"2";
            vc.title = @"最新产品";
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1) {
         [self startPlayer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set & get
- (UITableView *)shopTableView {
    if (!_shopTableView) {
        _shopTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight-49) style:UITableViewStyleGrouped];
        _shopTableView.dataSource = self;
        _shopTableView.delegate = self;
        _shopTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _shopTableView.estimatedSectionHeaderHeight = 0;
        _shopTableView.estimatedSectionFooterHeight = 5;
        _shopTableView.estimatedRowHeight = 270;
//        [_shopTableView registerClass:[ShopConfigCell class] forCellReuseIdentifier:NSStringFromClass([ShopConfigCell class])];
        [_shopTableView registerNib:[UINib nibWithNibName:@"ShopConfigCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopConfigCell class])];
        [_shopTableView registerNib:[UINib nibWithNibName:@"ShopVideoCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopVideoCell class])];
        [_shopTableView registerNib:[UINib nibWithNibName:@"ShopHotCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopHotCell class])];
        [_shopTableView registerNib:[UINib nibWithNibName:@"ShopNewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopNewCell class])];
        
    }
    return _shopTableView;
}

- (ShopTableHeaderView *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[ShopTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 250)];
    }
    return _tableHeader;
}
@end
