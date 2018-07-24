//
//  OrderDisViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "OrderDisViewController.h"
#import "OrderDisCell.h"

@interface OrderDisViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *couponArrs;
@property (nonatomic, strong) NSMutableArray *cellArr;

@end

@implementation OrderDisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    self.view.backgroundColor = [UIColor c_f6f6Color];
    [self requestDiscountInfo];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
    }];
    
    UIButton *bottomBtn = [[UIButton alloc]init];
    [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    bottomBtn.backgroundColor = [UIColor c_cc0Color];
    bottomBtn.layer.cornerRadius = 5;
    [bottomBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableview.mas_bottom);
        make.left.equalTo(@20);
        make.height.equalTo(@45);
        make.bottom.right.equalTo(@-20);
    }];
    
}

- (void)buttonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestDiscountInfo {
    
    @weakify(self);
    NSDictionary *param = @{@"order_amount":self.order_amount};
    [AFNetworkTool postJSONWithUrl:order_getOrderCoupon parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            self.couponArrs = [NSArray yy_modelArrayWithClass:[DiscountModel class] json:responseObject[@"content"][@"list"]];
            [self.tableview reloadData];
            
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } fail:^{
        
    }];
}
#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.couponArrs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDisCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDisCell class])];
    DiscountModel *model = self.couponArrs[indexPath.section];
    cell.discount = model;
    
//    if (![self.cellArr containsObject:cell]) {
//        [self.cellArr addObject:cell];
//    }
//    @weakify(self);
//    cell.operatorButtonBlock = ^{
//        @strongify(self);
//        for (OrderDisCell *temcell in self.cellArr) {
//            if (temcell != cell) {
//                temcell.selButton.selected = NO;
//            }
//        }
//        if (self.operatorOrderBlock) {
//            self.operatorOrderBlock(model);
//        }
//    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDisCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selButton.selected = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountModel *model = self.couponArrs[indexPath.section];
    OrderDisCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selButton.selected = YES;
    if (self.operatorOrderBlock) {
        self.operatorOrderBlock(model);
    }
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableview registerNib:[UINib nibWithNibName:@"OrderDisCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderDisCell class])];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 80;
        _tableview.tableFooterView = [UIView new];
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
    }
    return _tableview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)cellArr {
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

@end
