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
@property (weak, nonatomic) IBOutlet UILabel *power;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation JoinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加盟";
    [self requestJoin];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.power.mas_bottom).offset(16);
        make.bottom.equalTo(self.joinBtn.mas_top).offset(-15);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
}

- (void)requestJoin {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:join_Advantage_url parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            JoinModel *joinModel = [JoinModel yy_modelWithJSON:responseObject[@"content"]];
            self.joinMoney.text = [NSString stringWithFormat:@"￥%@", joinModel.join_money];
            [self.icon sd_setImageWithURL:[NSURL URLWithString:joinModel.join_pic] placeholderImage:[UIImage imageNamed:@"icon_35"]];
            [self.webview loadHTMLString:joinModel.advantage baseURL:nil];
            
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

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]init];
        _webview.backgroundColor = [UIColor whiteColor];
        _webview.scrollView.bounces = NO;
        _webview.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webview;
}

@end
