//
//  FirstRegViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "FirstRegViewController.h"
#import "SecondRegViewController.h"
@interface FirstRegViewController ()

@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation FirstRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configRegistUI];
}

- (void)configRegistUI {
    self.title = @"注册（1/2）";
}
- (IBAction)codeClick:(UIButton *)sender {
    
    if ([UIUtils checkPhoneNum:self.telField.text]) {
        [self startWithTime:59];
        NSDictionary *param = @{@"user_tel":self.telField.text,
                                @"code_type":@"1"
                   };
        @weakify(self);
        [AFNetworkTool postJSONWithUrl:me_getSMS_url parameters:param success:^(id responseObject) {
            @strongify(self);
            [Dialog popTextAnimation:responseObject[@"message"]];
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 202) {
                //已注册
                [self startWithTime:0];
                
            }
        } fail:^{
            
        }];
    }else {
        [Dialog popTextAnimation:@"请输入正确的手机号"];
    }
}
- (IBAction)registClick:(UIButton *)sender {
    if ([UIUtils isNullOrEmpty:self.telField.text]) {
        [Dialog popTextAnimation:@"请输入手机号"];
    }else if ([UIUtils isNullOrEmpty:self.codeField.text]) {
        [Dialog popTextAnimation:@"请输入验证码"];
    }else {
        SecondRegViewController *registVC = [[SecondRegViewController alloc]init];
        registVC.tel = self.telField.text;
        registVC.code = self.codeField.text;
        [self.navigationController pushViewController:registVC animated:YES];
    }
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
