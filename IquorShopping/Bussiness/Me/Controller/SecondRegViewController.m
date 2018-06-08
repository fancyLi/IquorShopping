//
//  SecondRegViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "SecondRegViewController.h"

@interface SecondRegViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *codeFeild;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *sureFeild;

@end

@implementation SecondRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configRegistUI];
}
- (void)configRegistUI {
    self.title = @"完善资料（2/2）";
}
- (IBAction)registClick:(UIButton *)sender {
   
    
    NSDictionary *param = @{@"user_name":self.nameField.text,
                            @"user_tel":self.tel,
                            @"verification_code":self.code,
                            @"parent_code":@"",
                            @"pass_word":self.passField.text,
                            @"pass_word_repeat":self.sureFeild.text
                            };
    [AFNetworkTool postJSONWithUrl:me_registone_url parameters:param success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            
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
