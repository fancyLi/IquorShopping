//
//  MerchantViewController.m
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MerchantViewController.h"
#import "MerchantCell.h"
#import "MerchantModel.h"
#import "MechantInfoViewController.h"
@interface MerchantViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;

@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"福利专区";
    [self.tableView registerNib:[UINib nibWithNibName:@"MerchantCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MerchantCell class])];
    self.tableView.rowHeight = 80;
    self.page = 1;
    self.tableView.tableFooterView = [UIView new];
    [self requestMerchantList];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.arrs = nil;
        [self requestMerchantList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestMerchantList];
    }];
}


- (void)requestMerchantList {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:merchant_url parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[MerchantModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
            }else {
                [Dialog popTextAnimation:self.page==1?@"暂无数据":@"没有下一页了"];
            }
            [self.tableView setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:@"暂无数据"];
            [self.tableView reloadData];
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}

- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MerchantCell class])];
    cell.merchant = self.arrs[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MechantInfoViewController *vc = [[MechantInfoViewController alloc]init];
    vc.merchant = self.arrs[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
