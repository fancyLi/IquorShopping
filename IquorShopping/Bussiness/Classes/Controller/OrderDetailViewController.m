//
//  OrderDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/20.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "IndentDetailCell.h"
#import "OrderDetailCell.h"
#import "IndentModel.h"

@interface OrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) UITableView *tableview;
@property (nonatomic, strong) IndentModel *indent;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self requestOrderInfo];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)requestOrderInfo {
    NSDictionary *param = @{@"order_id":self.order_id};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_orderInfo parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.indent = [IndentModel yy_modelWithDictionary:responseObject[@"content"]];
            [self.tableview reloadData];
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.indent.goods_list.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IndentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentDetailCell class])];
        cell.indent = self.indent.goods_list[indexPath.row];
        return cell;
    }
    OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell class])];
    return cell;
}
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.tableHeaderView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:@"IndentDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentDetailCell class])];
        [_tableview registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderDetailCell class])];
       
    }
    return _tableview;
}

@end
