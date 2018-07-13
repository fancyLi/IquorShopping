//
//  StartBaoViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/12.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "StartBaoViewController.h"
#import "BaoTableViewCell.h"
#import "BlanceBeforeModel.h"
#import "BaoCouViewController.h"
#import "BankUserViewController.h"
@interface StartBaoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputMoney;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UIButton *balanceBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *arrs;
@property (nonatomic, strong) BlanceBeforeModel *blanceBefor;
@property (nonatomic, strong) BankModel *bank;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, strong) NSMutableArray *cellArr;
@end

@implementation StartBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.arrs = @[@"支付宝", @"银行卡"];
    
    self.inputMoney.keyboardType = UIKeyboardTypeNumberPad;
    self.balanceBtn.layer.cornerRadius = 18;
    self.balanceBtn.layer.borderWidth = 1;
    self.balanceBtn.layer.borderColor = [UIColor c_ff8a00Color].CGColor;
    
    
    [self.tableview registerNib:[UINib nibWithNibName:@"BaoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BaoTableViewCell class])];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 70;
    self.tableview.sectionFooterHeight = 70;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestBankInfo];
}
- (void)requestBankInfo {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_theBalanceIsBefore parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.blanceBefor = [BlanceBeforeModel yy_modelWithDictionary:responseObject[@"content"]];
            self.balance.text = [NSString stringWithFormat:@"可提现余额：%@元", self.blanceBefor.balance];
            [self.tableview reloadData];
        }
    } fail:^{
        
    }];
}
- (IBAction)startBalance:(UIButton *)sender {
    if (self.inputMoney.text.floatValue>self.money.floatValue) {
        [Dialog popTextAnimation:@"提现金额不能大于可提现金额"];
    }else if ([UIUtils isNullOrEmpty:self.pay_type]) {
        [Dialog popTextAnimation:@"请选择提现方式"];
    }else if ([UIUtils isNullOrEmpty:self.inputMoney.text]) {
        [Dialog popTextAnimation:@"请输入提现金额"];
    }else {
        @weakify(self);
        NSDictionary *param = @{@"pay_type":self.pay_type, @"user_bank_id":@"", @"money":self.inputMoney.text};
        [AFNetworkTool postJSONWithUrl:user_balancePutForward parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        } fail:^{
            
        }];
    }
    
}


#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrs.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 70)];
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 12, kMainScreenWidth-40, 45)];
    sureButton.layer.cornerRadius = 5;
    sureButton.backgroundColor = [UIColor c_cc0Color];
    [sureButton setTitle:@"确定提现" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(startBalance:) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:sureButton];
    return bg;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaoTableViewCell class])];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.name.text = self.arrs[indexPath.row];
    if (indexPath.row == 0) {
        cell.icon.image = [UIImage imageNamed:@"icon_pay_01"];
        cell.count.text = [UIUtils isNullOrEmpty:self.blanceBefor.alipay_account]?@"":self.blanceBefor.alipay_account;
    }else {
        cell.icon.image = [UIImage imageNamed:@"icon_pay_04"];
        cell.count.text = [UIUtils isNullOrEmpty:self.blanceBefor.alipay_account]?@"":self.blanceBefor.bank_name;
        
    }
    if (![self.cellArr containsObject:cell]) {
        [self.cellArr addObject:cell];
    }
    @weakify(self);
    cell.operatorBaoCellBlock = ^(BOOL sel, BaoTableViewCell *cell) {
        @strongify(self);
        if (indexPath.row == 0) {
            self.pay_type = @"1";
        }else {
            self.pay_type = @"2";
        }
        for (BaoTableViewCell *temcell in self.cellArr) {
            if (temcell != cell) {
                temcell.operatorBtn.selected = NO;
            }
        }
    };
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        BaoCouViewController *vc = [[BaoCouViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        BankUserViewController *vc = [[BankUserViewController alloc]init];
        @weakify(self);
        vc.operatorUserBlock = ^(BankModel *bank) {
            @strongify(self);
            self.bank=bank;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)cellArr {
    if (!_cellArr) {
        _cellArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellArr;
}

@end
