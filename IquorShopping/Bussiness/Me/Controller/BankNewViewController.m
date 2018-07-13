//
//  BankNewViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BankNewViewController.h"
#import "BankInfoViewController.h"
#import "BankModel.h"
@interface BankNewViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bank;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *count;
@property (nonatomic, strong) NSArray *arrs;
@property (nonatomic, copy) NSString *secBankid;
@end


@implementation BankNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡账号";
    [self requestBankInfo];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(startEdit:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor c_333Color];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBankInfo)];
    [self.bank addGestureRecognizer:tapGes];
    // Do any additional setup after loading the view from its nib.
}
- (void)showBankInfo {
    BankInfoViewController *vc = [[BankInfoViewController alloc]init];
    vc.arrs = self.arrs;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }else{
        vc.modalPresentationStyle=UIModalPresentationCurrentContext;
    }
    @weakify(self);
    vc.operatorCellBlock = ^(BankModel *model) {
        @strongify(self);
        self.bank.text = model.bank_name;
        self.secBankid = model.bank_id;
    };
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)startEdit:(UIBarButtonItem *)item {
    if ([UIUtils isNullOrEmpty:self.bank.text]) {
        [Dialog popTextAnimation:@"选择开户行"];
    }else if ([UIUtils isNullOrEmpty:self.name.text]) {
        [Dialog popTextAnimation:@"填写真实姓名"];
    }else if ([UIUtils isNullOrEmpty:self.count.text]) {
        [Dialog popTextAnimation:@"填写银行卡账号"];
    }else {
        NSDictionary *param = @{@"bank_id":self.secBankid, @"user_name":self.name.text, @"bank_account":self.count.text};
        [AFNetworkTool postJSONWithUrl:user_addBankAccount parameters:param success:^(id responseObject) {
            
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
    
}

- (void)requestBankInfo {
    [AFNetworkTool postJSONWithUrl:user_getAListOfBanks parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.arrs = [NSArray yy_modelArrayWithClass:[BankModel class] json:responseObject[@"content"][@"bank_list"]];
        }else {
            
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
