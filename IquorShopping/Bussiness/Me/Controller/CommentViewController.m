//
//  CommentViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "CommentViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MeCommenCell.h"
#import "MeCommentModel.h"
@interface CommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的评价";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MeCommenCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MeCommenCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.page = 1;
    [self requestCouponList];
    
    @weakify(self);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.arrs = nil;
        [self requestCouponList];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestCouponList];
    }];
}
- (void)requestCouponList {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_goodsEvaluate parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[MeCommentModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.tableView reloadData];
            }else {
                [Dialog popTextAnimation:self.page==1?@"暂无数据":@"没有下一页了"];
            }
            [self.tableView setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:@"空空如也"];
            
        }else {
            [Dialog popTextAnimation:@"暂无数据"];
        }
    } fail:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([MeCommenCell class]) cacheByIndexPath:indexPath configuration:^(MeCommenCell *cell) {
        cell.comment = self.arrs[indexPath.section];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeCommenCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeCommenCell class])];
    cell.comment = self.arrs[indexPath.section];
    return cell;
}


- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

@end
