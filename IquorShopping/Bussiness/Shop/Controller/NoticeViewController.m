//
//  NoticeViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/20.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()
@property (nonatomic, strong) UILabel *notice;
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notice.text = self.noticeMsg;
    
    [self.view addSubview:self.notice];
    [self.view addSubview:self.webview];
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       "$img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",self.contect];
    [self.webview loadHTMLString:htmls baseURL:nil];
    [self.notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@44);
        make.top.mas_equalTo(kStatusBarHeight);
    }];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.notice.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)notice {
    if (!_notice) {
        _notice = [[UILabel alloc]init];
        _notice.textColor = [UIColor blackColor];
        _notice.textAlignment = NSTextAlignmentCenter;
        _notice.font = [UIFont systemFontOfSize:17];
    }
    return _notice;
}
- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]init];
        _webview.scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _webview;
}

@end
