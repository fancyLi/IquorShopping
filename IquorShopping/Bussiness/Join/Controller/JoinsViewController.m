//
//  JoinsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "JoinsViewController.h"
#import "JoinModel.h"
@interface JoinsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *joinMoney;
@property (weak, nonatomic) IBOutlet UITextView *joinLaw;

@end

@implementation JoinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加盟";
    [self requestJoin];
   
}

- (void)requestJoin {
    WeakObj(self);
    [AFNetworkTool postJSONWithUrl:join_Advantage_url parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            JoinModel *joinModel = [JoinModel yy_modelWithJSON:responseObject[@"content"]];
            selfWeak.joinMoney.text = joinModel.join_money;
            [selfWeak.icon sd_setImageWithURL:[NSURL URLWithString:joinModel.join_pic] placeholderImage:[UIImage imageNamed:@"icon_35"]];
            selfWeak.joinLaw.text = joinModel.advantage;
                        
        }else {
        }
    } fail:^{
        
    }];
}

- (IBAction)startJoin:(UIButton *)sender {
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
