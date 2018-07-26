//
//  LoginOperator.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "LoginOperator.h"
#import "LoginViewController.h"

@implementation LoginOperator
singtonImplement(LoginOperator)

- (void)loginVC:(void (^)(BOOL))complation {
    LoginViewController *vc = [[LoginViewController alloc]init];
    vc.loginOperatorBlock = ^(BOOL isScu) {
        complation(isScu);
        
    };
    [LoginOperator.getCurrentVC.navigationController pushViewController:vc animated:YES];
}

- (void)alertLogin {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您尚未登录，是否现在登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[LoginOperator shareInstance] loginVC:^(BOOL isScu) {
            [LoginOperator.getCurrentVC.navigationController popViewControllerAnimated:YES];
        }];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [LoginOperator.getCurrentVC presentViewController:alertVC animated:YES completion:nil];
}

- (void)alertAuth {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请检查网络是否连接" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"]];
        }
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [LoginOperator.getCurrentVC presentViewController:alertVC animated:YES completion:nil];
}
- (void)ensconceLogin {
//    NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
//    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
    NSString *tel = [IQourUser shareInstance].tel;
    NSString *pwd = [IQourUser shareInstance].pwd;
    if (tel && pwd) {
        NSDictionary *param = @{@"user_tel":tel,
                                @"pass_word":pwd
                                };
        
        [AFNetworkTool postJSONWithUrl:me_login_url parameters:param success:^(id responseObject) {
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                [PDDDataManger saveLoginCookie];
                [self getUserInfo];
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
            [IQourUser yy_modelWithDictionary:responseObject[@"content"]];
            [[IQourUser shareInstance] save];
        }else {
            
        }
    } fail:^{
        
    }];
}
@end
