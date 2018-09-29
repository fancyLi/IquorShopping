//
//  PageDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "PageDetailViewController.h"

@interface PageDetailViewController ()
@property (nonatomic, strong) UIWebView *webview;
@end

@implementation PageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
}
- (void)setGoods_detail:(NSString *)goods_detail {
    _goods_detail = goods_detail;
    NSString *HTML = [NSString stringWithFormat:@"<html> \n"
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
                      "</html>",_goods_detail];
    [self.webview loadHTMLString:HTML baseURL:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]init];
        _webview.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webview;
}

@end
