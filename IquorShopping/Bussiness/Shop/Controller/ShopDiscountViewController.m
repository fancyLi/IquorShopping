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
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)requestDiscountInfo {
    
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:index_aCouponThatCanBeReceived parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        
        if (code == 200) {
            self.couponArrs = [NSArray yy_modelArrayWithClass:[DiscountModel class] json:responseObject[@"content"]];
            [self.tableview reloadData];
            
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } fail:^{
        
    }];
}

- (void)getDiscountCoupon:(DiscountModel *)model {
    @weakify(self);
    NSDictionary *param = @{@"cid": model.ucid};
    [AFNetworkTool postJSONWithUrl:index_receiveCoupon parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        
        if (code == 200) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
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
    DiscountModel *model = self.couponArrs[indexPath.section];
    [cell configPreviewCell:model];
    @weakify(self);
    cell.operatorButtonBlock = ^{
        @strongify(self);
        [self getDiscountCoupon:model];
    };
    return cell;
}



- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableview registerNib:[UINib nibWithNibName:@"DiscountCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([DiscountCell class])];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.rowHeight = 80;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
    }
    return _tableview;
}

@end
