//
//  ChangePasswordViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *changePasswordField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordField;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configChangeUI];
    
}

- (void)configChangeUI {
    self.title = @"修改密码";
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
   
}
- (void)saveClick:(UIButton *)barItem {
    
    if ([UIUtils isNullOrEmpty:self.oldPasswordField.text]) {
        [Dialog popTextAnimation:@"请输入原密码"];
    }else if ([UIUtils isNullOrEmpty:self.changePasswordField.text]) {
        [Dialog popTextAnimation:@"请输入新密码"];
    }else if ([UIUtils isNullOrEmpty:self.changePasswordField.text]) {
        [Dialog popTextAnimation:@"请重复输入新密码"];
    }else {
        NSDictionary *param = @{@"pass_word_old":self.oldPasswordField.text,
                                @"pass_word":self.changePasswordField.text,
                                @"pass_word_repeat":self.surePasswordField.text
                                };
        [AFNetworkTool postJSONWithUrl:me_changePassword_url parameters:param success:^(id responseObject) {
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
