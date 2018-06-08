//
//  ResetPasswordViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telFeild;
@property (weak, nonatomic) IBOutlet UITextField *codeFeild;
@property (weak, nonatomic) IBOutlet UITextField *passFeild;

@property (weak, nonatomic) IBOutlet UITextField *sureFeild;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configResetUI];
    
}
- (void)configResetUI {
    self.title = @"重置密码";
}
- (IBAction)codeClick:(UIButton *)sender {
    if ([UIUtils checkPhoneNum:self.telFeild.text]) {
        [self startWithTime:60];
        NSDictionary *param = @{@"user_tel":self.telFeild.text,
                                @"code_type":@"2"
                                };
        [AFNetworkTool postJSONWithUrl:me_getSMS_url parameters:param success:^(id responseObject) {
            
        } fail:^{
            
        }];
    }else {
        [Dialog popTextAnimation:@"请输入正确的手机号"];
    }
}
- (IBAction)sureClick:(UIButton *)sender {
    NSDictionary *param = @{@"user_tel":self.telFeild.text,
                            @"verification_code": self.codeFeild.text,
                            @"pass_word":self.passFeild.text,
                            @"pass_word_repeat": self.sureFeild.text
                            };
    [AFNetworkTool postJSONWithUrl:me_resetPassword_url parameters:param success:^(id responseObject) {
        
    } fail:^{
        
    }];
}


- (void)startWithTime:(NSInteger)timeLine {
    
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [weakSelf.codeBtn setTitleColor:[UIColor c_cc0Color] forState:UIControlStateNormal];
                weakSelf.codeBtn.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.codeBtn setTitle:[NSString stringWithFormat:@"%@s后重发",timeStr] forState:UIControlStateNormal];
                [weakSelf.codeBtn setTitleColor:[UIColor c_666Color] forState:UIControlStateNormal];
                weakSelf.codeBtn.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
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
