//
//  NikeNameViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NikeNameViewController.h"

@interface NikeNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nikeNameField;

@end

@implementation NikeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNikeUI];
    
}
- (void)configNikeUI {
    
    if (self.isCode) {
        self.title = @"填写邀请码";
    }else {
        self.title = @"昵称";
        self.nikeNameField.text = self.nike;
    }
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    
}
- (void)saveClick:(UIButton *)barItem {
    
    NSDictionary *param;
    NSString *urlStr;
    if ([UIUtils isNullOrEmpty:self.nikeNameField.text]) {
      
        [Dialog popTextAnimation:self.isCode?@"请填写邀请码":@"请输入昵称"];
    }else {
        if (self.isCode) {
            param = @{@"user_code":self.nikeNameField.text
                      };
            urlStr = user_modifyTheUserCode;
        }else {
            param = @{@"nick_name":self.nikeNameField.text
                      };
            urlStr = update_nikename_url;
        }
        [AFNetworkTool postJSONWithUrl:urlStr parameters:param success:^(id responseObject) {
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                [[IquorDataManager shareInstance] updateUserInfo:^(BOOL isScu) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }];                
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
