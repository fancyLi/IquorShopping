//
//  MsgViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MsgViewController.h"

@interface MsgViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *msgTitle;
@property (weak, nonatomic) IBOutlet UITextView *msgContent;
@property (weak, nonatomic) IBOutlet UILabel *placehold;

@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线留言";
    self.msgContent.delegate = self;
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    // Do any additional setup after loading the view from its nib.
}
- (void)saveClick:(UIButton *)barItem {
    
    if ([UIUtils isNullOrEmpty:self.msgTitle.text]) {
        [Dialog popTextAnimation:@"请输入留言标题"];
    }else if ([UIUtils isNullOrEmpty:self.msgContent.text]) {
        [Dialog popTextAnimation:@"请填写您的意见或建议"];
    }else {
        NSDictionary *param = @{
                                @"title":self.msgTitle.text,
                                @"content":self.msgContent.text
                                };
        [AFNetworkTool postJSONWithUrl:msg_upload_url parameters:param success:^(id responseObject) {
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

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placehold.hidden = YES;
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
