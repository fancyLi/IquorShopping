//
//  LoginViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "LoginViewController.h"
#import "FirstRegViewController.h"
#import "ResetPasswordViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLoginUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)configLoginUI {
    self.title = @"登录";
    self.registBtn.layer.cornerRadius = 5;
    self.registBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.registBtn.layer.borderWidth = 1;
    self.registBtn.layer.masksToBounds = YES;
}
- (void)reloadLogin {
    
}
- (IBAction)forgetClick:(UIButton *)sender {
    ResetPasswordViewController *resetVC = [[ResetPasswordViewController alloc]init];
    [self.navigationController pushViewController:resetVC animated:YES];
}
- (IBAction)registClick:(UIButton *)sender {
    FirstRegViewController *registVC = [[FirstRegViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
- (IBAction)loginClick:(UIButton *)sender {
    if ([UIUtils isNullOrEmpty:self.telField.text]) {
        [Dialog popTextAnimation:@"请输入手机号"];
    }else if ([UIUtils isNullOrEmpty:self.passwordField.text]) {
        [Dialog popTextAnimation:@"请输入密码"];
    }else {
        NSDictionary *param = @{@"user_tel":self.telField.text,
                                @"pass_word":self.passwordField.text
                                };
        
        [[NSUserDefaults standardUserDefaults] setObject:self.telField.text forKey:@"tel"];
        [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:@"pwd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [AFNetworkTool postJSONWithUrl:me_login_url parameters:param success:^(id responseObject) {
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                
                [PDDDataManger saveLoginCookie];
                [self getUserInfo];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else {
                
            }
        } fail:^{
            
        }];
    }
}
- (void)getUserInfo {

    [AFNetworkTool postJSONWithUrl:get_user_info_url parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
//            IquorUser *user = [IquorUser shareIquorUser];
//            [user configDict:responseObject[@"content"]];
            [IQourUser yy_modelWithDictionary:responseObject[@"content"]];
            [[IQourUser shareInstance] save];
        }else {
            
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
