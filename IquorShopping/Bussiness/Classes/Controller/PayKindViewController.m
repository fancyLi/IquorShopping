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
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, copy) NSString *curPayType;
@end

@implementation PayKindViewController

- (void)viewDidLoad {
    self.title = @"选择付款方式";
    [super viewDidLoad];
    [self requestPay];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.sureBtn];
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(20);
        make.top.equalTo(self.tableview.mas_bottom);
    }];
    // Do any additional setup after loading the view.
}

- (void)sureButtonClick {
    if (self.operatorPayCellBlock && ![UIUtils isNullOrEmpty:self.curPayType]) {
        self.operatorPayCellBlock(self.curPayType);
    }else {
        [Dialog popTextAnimation:@"请选择付款方式"];
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaoTableViewCell class])];
    OrderPay *pay = self.arr[indexPath.row];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:pay.pic]];
    cell.name.text = pay.type_name;
    if (![self.cellArr containsObject:cell]) {
        [self.cellArr addObject:cell];
    }
    @weakify(self);
    cell.operatorBaoCellBlock = ^(BOOL sel, BaoTableViewCell *cell) {
        @strongify(self);
        self.curPayType = pay.pay_type;
        for (BaoTableViewCell *temcell in self.cellArr) {
            if (temcell != cell) {
                temcell.operatorBtn.selected = NO;
            }
        }
    };
    return cell;
    
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
        _tableview.tableFooterView = [UIView new];
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
- (NSMutableArray *)cellArr {
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

@end
