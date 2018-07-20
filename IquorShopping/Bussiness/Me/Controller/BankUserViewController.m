//
//  BankUserViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BankUserViewController.h"
#import "BankNewViewController.h"
#import "BankUserCell.h"
@interface BankUserViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *arrs;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) BankModel *curBank;
@end

@implementation BankUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    self.view.backgroundColor = [UIColor c_f6f6Color];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(startEdit:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor c_333Color];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)startEdit:(UIBarButtonItem *)item {
    if (self.operatorUserBlock) {
        self.operatorUserBlock(self.curBank);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestUserBank];
}

- (void)addNewBank {
    BankNewViewController *vc = [[BankNewViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)requestUserBank {
    [AFNetworkTool postJSONWithUrl:user_userBankAccountList parameters:nil success:^(id responseObject) {
        
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.arrs = [NSArray yy_modelArrayWithClass:[BankModel class] json:responseObject[@"content"][@"bank_list"]];
            [self.tableview reloadData];
        }else {
            
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 70)];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, kMainScreenWidth, 45)];
    button.backgroundColor = [UIColor whiteColor];
    [button setImage:[UIImage imageNamed:@"add_bank"] forState:UIControlStateNormal];
    [button setTitle:@"添加新的银行卡" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(addNewBank) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:button];
    return bg;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BankUserCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.bank = self.arrs[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.curBank = self.arrs[indexPath.row];
    BankUserCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.operatorBtn.selected = YES;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    BankUserCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.operatorBtn.selected = NO;
}



- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor c_f6f6Color];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.sectionFooterHeight = 55;
        _tableview.rowHeight = 65;
        [_tableview registerNib:[UINib nibWithNibName:@"BankUserCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BankUserCell class])];
    }
    return _tableview;
}
- (NSMutableArray *)cellArr {
    if (!_cellArr) {
        _cellArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellArr;
}

@end
