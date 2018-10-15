//
//  LoveViewController.m
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "LoveViewController.h"

#import "ShopLoverCell.h"

#import "HomePageModel.h"

@interface LoveViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *donateTotal;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;

@end

@implementation LoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"爱心窗口";
    
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopLoverCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopLoverCell class])];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    self.page = 1;
    [self requestDonateList];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.arrs = nil;
        [self requestDonateList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestDonateList];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)requestDonateList {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:lover_url parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[Lover class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
            }else {
                [Dialog popTextAnimation:self.page==1?responseObject[@"message"]:@"没有下一页了"];
            }
            [self.tableView setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:responseObject[@"message"]];
            [self.tableView reloadData];
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
        
        self.stackView.hidden =self.arrs.count ? NO : YES;
       
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    ShopLoverCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopLoverCell class])];
    cell.lover = self.arrs[indexPath.row];
    return cell;
}

@end
