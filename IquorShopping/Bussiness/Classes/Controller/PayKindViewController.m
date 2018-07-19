//
//  PayKindViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "PayKindViewController.h"
#import "OrderPay.h"
#import "BaoTableViewCell.h"
@interface PayKindViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, copy) NSString *curPayType;
@end

@implementation PayKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择付款方式";
    self.view.backgroundColor = [UIColor c_f6f6Color];
    [self requestPay];
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.sureBtn];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.tableview.mas_bottom);
        make.height.equalTo(@45);
    }];
    // Do any additional setup after loading the view.
}

- (void)sureButtonClick {
    if (self.operatorPayCellBlock && ![UIUtils isNullOrEmpty:self.curPayType]) {
        self.operatorPayCellBlock(self.curPayType);
    }else {
        [Dialog popTextAnimation:@"请选择付款方式"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestPay {
    @weakify(self);
    NSDictionary *param = @{@"pay_scene":self.pay_scene};
    [AFNetworkTool postJSONWithUrl:index_paymentType parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.arr = [NSArray yy_modelArrayWithClass:[OrderPay class] json:responseObject[@"content"][@"pay_type"]];
            [self.tableview reloadData];
           
        }
    } fail:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaoTableViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderPay *pay = self.arr[indexPath.section];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:pay.pic]];
    cell.name.text = pay.type_name;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.operatorBtn.selected = NO;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.operatorBtn.selected = YES;
    OrderPay *pay = self.arr[indexPath.section];
    self.curPayType = pay.pay_type;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.rowHeight = 45;
        _tableview.backgroundColor = [UIColor c_f6f6Color];
        _tableview.tableFooterView = [UIView new];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerNib:[UINib nibWithNibName:@"BaoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BaoTableViewCell class])];
    }
    return _tableview;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]init];
        _sureBtn.backgroundColor = [UIColor c_cc0Color];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.layer.cornerRadius= 5;
        [_sureBtn addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}


@end
