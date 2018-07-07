
//
//  DetailTableFooter.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DetailTableFooter.h"
@interface DetailTableFooter ()

@property (nonatomic, strong) UIWebView *webview;
@end
@implementation DetailTableFooter

- (instancetype)init {
    self = [super init];
    if (self) {
         [self setupSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews {
    [self addSubview:self.webview];
    UIView *back = [[UIView alloc]init];
    back.backgroundColor = [UIColor whiteColor];
    [self addSubview:back];
    UILabel *title = [[UILabel alloc]init];
    title.text = @"商品详情";
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor c_333Color];
    [self addSubview:title];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor c_f6f6Color];
    [self addSubview:line];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.equalTo(@50);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self).offset(10);
        make.height.equalTo(@50);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom);
        make.height.equalTo(@1);
        make.left.right.equalTo(self);
    }];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}
- (void)setFrament:(NSString *)frament {
    _frament = frament;
    //解决图片自使用
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
                       "$img[p].style.width = '90%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",_frament];
    [self.webview loadHTMLString:htmls baseURL:nil];
}

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]init];
        _webview.scrollView.bounces = NO;
        _webview.scrollView.showsVerticalScrollIndicator = NO;
        _webview.scrollView.showsHorizontalScrollIndicator = NO;
        _webview.backgroundColor = [UIColor whiteColor];
    }
    return _webview;
}

@end
