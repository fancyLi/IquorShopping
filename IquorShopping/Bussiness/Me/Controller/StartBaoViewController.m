//
//  StartBaoViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/12.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "StartBaoViewController.h"
#import "BaoTableViewCell.h"

@interface StartBaoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputMoney;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UIButton *balanceBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSArray *arrs;

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
    self.balance.text = [NSString stringWithFormat:@"可提现余额：%@元", self.money];
    [self.tableview registerNib:[UINib nibWithNibName:@"BaoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BaoTableViewCell class])];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 70;
    self.tableview.sectionFooterHeight = 70;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)startBalance:(UIButton *)sender {
    if (self.inputMoney.text.floatValue>self.money.floatValue) {
        [Dialog popTextAnimation:@"提现金额不能大于可提现金额"];
    }else {
        @weakify(self);
        NSDictionary *param = @{@"pay_type":@"", @"user_bank_id":@"", @"money":@""};
        [AFNetworkTool postJSONWithUrl:user_balancePutForward parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
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
    }else {
        cell.icon.image = [UIImage imageNamed:@"icon_pay_04"];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
