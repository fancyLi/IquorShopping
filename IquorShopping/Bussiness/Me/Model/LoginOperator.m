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
    [LoginOperator.getCurrentVC.navigationController pushViewController:vc animated:YES];
}

- (void)ensconceLogin {
    NSString *tel = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
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
