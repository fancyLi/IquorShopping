//
//  ShopDiscountViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/1.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopDiscountViewController.h"
#import "DiscountCell.h"
#import "DiscountModel.h"

@interface ShopDiscountViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *couponArrs;
@end

@implementation ShopDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    [self requestDiscountInfo];
    [self.view addSubview:self.tableview];
}

- (void)requestDiscountInfo {
    
    WeakObj(self);
    [AFNetworkTool postJSONWithUrl:index_aCouponThatCanBeReceived parameters:nil success:^(id responseObject) {
        
        
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        
        if (code == 200) {
            selfWeak.couponArrs = [NSArray yy_modelArrayWithClass:[DiscountModel class] json:responseObject[@"message"][@"list"]];
            [selfWeak.tableview reloadData];
            
        }else {
            [selfWeak.navigationController popViewControllerAnimated:YES];
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
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DiscountCell class])];
    [cell configPreviewCell:self.couponArrs[indexPath.section]];
    return cell;
}



- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableview registerNib:[UINib nibWithNibName:@"DiscountCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([DiscountCell class])];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 70;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
    }
    return _tableview;
}

@end
