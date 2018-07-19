//
//  IndentListViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentListViewController.h"
#import "IndentDetailViewController.h"
#import "IndentDetailCell.h"
#import "HeaderTableView.h"
#import "FooterTableView.h"
#import "IndentModel.h"
#import "EveGoodsViewController.h"
#import "OrderDetailViewController.h"
@interface IndentListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *indentTable;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;
@end

@implementation IndentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.indentTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.page = 1;
    [self requestOrderList];
    [self.view addSubview:self.indentTable];
    [self.indentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

//订单处理
- (void)orderHandle:(IndentModel *)indent detailType:(NSString *)type{
    //处理状态 'pay'=>去支付 'confirm'=>确认收货 'cancel'=>取消订单 'del'=>删除订单
    NSDictionary *param = @{@"order_id":indent.order_id, @"deal_type":type};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_userOrderDeal parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            self.page = 1;
            self.arrs = nil;
            [self requestOrderList];
        }else {
        }
    } fail:^{
        
    }];
}
- (void)requestOrderList {
    NSDictionary *param = @{@"page":@(self.page), @"order_type":self.order_type};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_userOrderList parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.indentTable.mj_footer endRefreshing];
        [self.indentTable.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[IndentModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.indentTable reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
            [self.indentTable setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:@"还没有订单哦"];
            
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark action
- (void)cancelOrder:(IndentModel *)indent {
    [self orderHandle:indent detailType:@"cancel"];
}
- (void)deleteOrder:(IndentModel *)indent {
    [self orderHandle:indent detailType:@"del"];
}
- (void)payOrder:(IndentModel *)indent {
    [self orderHandle:indent detailType:@"pay"];
}
- (void)sureOrder:(IndentModel *)indent {
    [self orderHandle:indent detailType:@"confirm"];
}
- (void)eveOrder:(IndentModel *)indent {
    EveGoodsViewController *vc = [[EveGoodsViewController alloc]init];
    vc.order_id = indent.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IndentModel *indent = self.arrs[section];
    return indent.goods_list.count;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderTableView *headView = [[NSBundle mainBundle] loadNibNamed:@"HeaderTableView" owner:self options:nil].firstObject;
    IndentModel *indent = self.arrs[section];
    headView.leftTitle.text = [NSString stringWithFormat:@"订单编号：%@", indent.order_sn];
    headView.rightTitle.text = indent.order_actname;
    return headView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FooterTableView *footView = [[NSBundle mainBundle] loadNibNamed:@"FooterTableView" owner:self options:nil].firstObject;
    IndentModel *indent = self.arrs[section];
//    *此处订单状态的逻辑为:
//    *act=1 待付款状态               付款按钮 和  取消按钮同存在
//    *act=2 处于已支付，待发货状态   不需要按钮
//    *act=3 处于已发货，待收货状态   确认收货按钮
//    *act=4  删除订单按钮 act=4和 order_eval=1 并存的情况下 处于待评价状态   评价按钮存在
//    *act>4 删除订单按钮
    @weakify(self);
    if (indent.act.intValue == 1) {
        [footView.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [footView.rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
        footView.operatorBlock = ^(BOOL isLeft) {
            @strongify(self);
            if (isLeft) {
                [self cancelOrder:indent];
            }else {
                [self payOrder:indent];
            }
        };
    }else if (indent.act.intValue == 2) {
        footView.leftBtn.hidden = YES;
        footView.rightBtn.hidden = YES;
    }else if (indent.act.intValue == 3) {
        footView.leftBtn.hidden = YES;
        [footView.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        footView.operatorBlock = ^(BOOL isLeft) {
            @strongify(self);
            if (!isLeft) {
                [self sureOrder:indent];
            }
        };
    }else if (indent.act.intValue == 4 && indent.order_eval.intValue == 1) {
        [footView.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [footView.rightBtn setTitle:@"评价" forState:UIControlStateNormal];
        footView.operatorBlock = ^(BOOL isLeft) {
            @strongify(self);
            if (isLeft) {
                [self deleteOrder:indent];
            }else {
                [self eveOrder:indent];
            }
        };
    }else if (indent.act.intValue>4) {
        [footView.leftBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [footView.rightBtn setTitle:@"已评价" forState:UIControlStateNormal];
        footView.rightBtn.backgroundColor = UIColorFromRGB(0xC7C7C7);
        footView.rightBtn.enabled = NO;
        footView.operatorBlock = ^(BOOL isLeft) {
            @strongify(self);
            if (isLeft) {
                [self deleteOrder:indent];
            }
        };
    }
    return footView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IndentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentDetailCell class])];
    IndentModel *indent = self.arrs[indexPath.section];
    cell.indent = indent.goods_list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IndentModel *indent = self.arrs[indexPath.section];
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
    vc.order_id = indent.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableView *)indentTable {
    if (!_indentTable) {
        _indentTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_indentTable registerNib:[UINib nibWithNibName:@"IndentDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentDetailCell class])];
        _indentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _indentTable.rowHeight = 100;
        _indentTable.estimatedSectionHeaderHeight = 0;
        _indentTable.estimatedSectionFooterHeight = 50;
        _indentTable.delegate = self;
        _indentTable.dataSource = self;
        @weakify(self);
        self.indentTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            self.arrs = nil;
            [self requestOrderList];
        }];
        self.indentTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page++;
            [self requestOrderList];
        }];
    }
    return _indentTable;
}

- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}
@end
