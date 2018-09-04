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
#import "OrderFooterView.h"
#import "EveGoodsViewController.h"
#import "OrderHeaderView.h"


@interface OrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) UITableView *tableview;
@property (nonatomic, strong) IndentModel *indent;
@property (nonatomic, strong) OrderFooterView *footer;
@property (nonatomic, strong) OrderHeaderView *header;
@property (nonatomic, copy) NSString *code;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor c_f6f6Color];
    [self requestOrderInfo];
    
}
- (void)setupSubviews {
    
    [self.tableview reloadData];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.header;
    self.header.nameCon.text = [NSString stringWithFormat:@"%@   %@", self.indent.order_addr.contact_name, self.indent.order_addr.contact_tel];
    self.header.userAdress.text = [NSString stringWithFormat:@"%@%@%@%@", self.indent.order_addr.province_name, self.indent.order_addr.city_name, self.indent.order_addr.district_name, self.indent.order_addr.contact_addr];
    
    BOOL isFooter;
    if (self.indent.order_info.act.intValue == 1) {
        //待付款
        self.footer.leftBtn.tag = 1000;
        self.footer.rightBtn.tag = 1001;
        isFooter = YES;
    }else if (self.indent.order_info.act.intValue == 2) {
        //待发货
        isFooter = NO;
    }else if (self.indent.order_info.act.intValue == 3) {
        //待收货
        isFooter = YES;
        self.footer.rightBtn.tag = 1002;
        self.footer.leftBtn.hidden = YES;
    }else if (self.indent.order_info.act.intValue == 4 && self.indent.order_info.order_eval.intValue == 1) {
        //待
        isFooter = YES;
        self.footer.leftBtn.tag = 1003;
        self.footer.rightBtn.tag = 1004;
        [self.footer.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    }else {
        isFooter = YES;
        self.footer.leftBtn.hidden = YES;
        self.footer.rightBtn.tag = 1003;
        [self.footer.rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    self.footer.price.text = [NSString stringWithFormat:@"应支付：￥%@", self.indent.order_info.order_amount];

    if (isFooter) {
        [self.view addSubview:self.footer];
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
        }];
        [self.footer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableview.mas_bottom);
            make.left.bottom.right.equalTo(self.view);
            make.height.equalTo(@50);
        }];
    }else {
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
   
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.header.frame = CGRectMake(0, 0, kMainScreenWidth, 100);
}
//去评价
- (void)startCom {
    EveGoodsViewController *vc = [[EveGoodsViewController alloc]init];
    vc.order_id = self.indent.order_info.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}
//去付款
- (void)startPay {
    @weakify(self);
    
        NSDictionary *param = @{@"pay_type":self.indent.order_info.pay_type,
                                @"pay_scene":@"5",
                                @"order_id":self.indent.order_info.order_id
                               };
   
    [[IquorDataManager shareInstance] submitOrderParameters:param payKind:self.indent.order_info.pay_type enterVC:YES orderCom:^(BOOL isScu) {
        
    }];

}


- (void)requestOrderInfo {
    NSDictionary *param = @{@"order_id":self.order_id};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_orderInfo parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.indent = [IndentModel yy_modelWithDictionary:responseObject[@"content"]];
            [self setupSubviews];
        }
    } fail:^{
        
    }];
}

//订单处理
- (void)orderHandle:(NSString *)type{
    //处理状态 'pay'=>去支付 'confirm'=>确认收货 'cancel'=>取消订单 'del'=>删除订单
    NSDictionary *param = @{@"order_id":self.indent.order_info.order_id, @"deal_type":type};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_userOrderDeal parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.indent.goods_list.count;
    }else if (section == 1) {
        return 5;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IndentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentDetailCell class])];
        cell.orderIndent = self.indent.goods_list[indexPath.row];
        return cell;
    }else if (indexPath.section == 1) {
        
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell class])];
        if (indexPath.row == 0) {
            cell.leftTitle.text = @"订单编号：";
            cell.rightTitle.text = self.indent.order_info.order_sn;
        }else if (indexPath.row == 1) {
            cell.leftTitle.text = @"下单时间：";
            cell.rightTitle.text = self.indent.order_info.addtime;
        }else if (indexPath.row == 2) {
            cell.leftTitle.text = @"支付方式：";
            cell.rightTitle.text = self.indent.order_info.pay_type_name;
        }else if (indexPath.row == 3) {
            cell.leftTitle.text = @"优惠券：";
            cell.rightTitle.text = self.indent.order_info.coupon_money;
        }else if (indexPath.row == 4) {
            cell.leftTitle.text = @"会员抵扣：";
            cell.rightTitle.text = self.indent.order_info.discount_money;
        }
        return cell;
    }else if (indexPath.section == 2) {
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailCell class])];
        cell.leftTitle.text = @"应付合计：";
        cell.rightTitle.text = self.indent.order_info.order_amount;
        return cell;
    }
    
    return nil;
}
- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.estimatedSectionFooterHeight = 5;
        _tableview.estimatedSectionHeaderHeight = 5;
        _tableview.backgroundColor = [UIColor c_f6f6Color];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerNib:[UINib nibWithNibName:@"IndentDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentDetailCell class])];
        [_tableview registerNib:[UINib nibWithNibName:@"OrderDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderDetailCell class])];
       
    }
    return _tableview;
}
- (OrderHeaderView *)header {
    if (!_header) {
        _header = [[NSBundle mainBundle] loadNibNamed:@"OrderHeaderView" owner:self options:nil].firstObject;
    }
    return _header;
}

- (OrderFooterView *)footer {
    if (!_footer) {
        _footer = [[NSBundle mainBundle] loadNibNamed:@"OrderFooterView" owner:self options:nil].firstObject;
        @weakify(self);
        _footer.orderFooterBlock = ^(NSInteger tag) {
            @strongify(self);
             if (tag == 1000) {
                [self orderHandle:@"cancel"];
            }else if (tag == 1001) {
                [self startPay];
            }else if (tag == 1002) {
                [self orderHandle:@"confirm"];
            }else if (tag == 1003) {
                [self orderHandle:@"del"];
            }else if (tag == 1004) {
                [self startCom];
            }
        };
      
    }
    return _footer;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
