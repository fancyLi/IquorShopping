//
//  AssessViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AssessViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "AssessCell.h"
#import "CommentModel.h"
@interface AssessViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *assessTable;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;
@end

@implementation AssessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self requestCouponList];
    [self.view addSubview:self.assessTable];
    [self.assessTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(@0);
    }];
}

- (void)requestCouponList {
    NSDictionary *param = @{@"page":@(self.page),@"goods_id":self.goods_id};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:shop_goodsComment parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.assessTable.mj_footer endRefreshing];
        [self.assessTable.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[CommentModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.assessTable reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}
#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([AssessCell class]) configuration:^(id cell) {
        [cell configCell:self.arrs[indexPath.row]];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssessCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AssessCell class])];
    [cell configCell:self.arrs[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & get
- (UITableView *)assessTable {
    if (!_assessTable) {
        _assessTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_assessTable registerNib:[UINib nibWithNibName:@"AssessCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AssessCell class])];
//        _assessTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _assessTable.dataSource = self;
        _assessTable.delegate = self;
        _assessTable.tableFooterView = [UIView new];
        @weakify(self);
        _assessTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            self.arrs = nil;
            [self requestCouponList];
        }];
        _assessTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page++;
            [self requestCouponList];
        }];
        
    }
    return _assessTable;
}
- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

@end
