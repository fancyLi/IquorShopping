//
//  AboutViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self requestAbout];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
}

- (void)requestAbout {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_aboutUs parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
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
                               "</html>",responseObject[@"content"][@"content"]];
            [self.webView loadHTMLString:htmls baseURL:nil];
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}
@end
