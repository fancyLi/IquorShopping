//
//  BaoCouViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BaoCouViewController.h"
#import "BankModel.h"
@interface BaoCouViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *count;
@property (nonatomic, strong) BankModel *bank;
@end

@implementation BaoCouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝账号";
    [self requestBaoInfo];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(startEdit:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor c_333Color];
    // Do any additional setup after loading the view from its nib.
}
- (void)configBaoInfo {
    self.name.text = self.bank.alipay_name;
    self.count.text = self.bank.alipay_account;
}
- (void)requestBaoInfo {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_aliPayAccountInfo parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.bank = [BankModel yy_modelWithDictionary:responseObject[@"content"][@"alipay"]];
            [self configBaoInfo];
        }
    } fail:^{
        
    }];
}
- (void)startEdit:(UIBarButtonItem *)item {
    if ([UIUtils isNullOrEmpty:self.name.text]) {
        [Dialog popTextAnimation:@"填写真实姓名"];
    }else if ([UIUtils isNullOrEmpty:self.count.text]) {
        [Dialog popTextAnimation:@"填写支付宝账号"];
    }else {
        NSDictionary *param = @{@"alipay_name":self.name.text, @"alipay_account":self.count.text};
        [AFNetworkTool postJSONWithUrl:user_addOrEditAliPayAccount parameters:param success:^(id responseObject) {
            
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
