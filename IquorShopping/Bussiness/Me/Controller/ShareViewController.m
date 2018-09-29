//
//  ShareViewController.m
//  IquorShopping
//
//  Created by nanli on 2018/9/27.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "IquorButton.h"
@interface ShareViewController ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) IquorButton *weChatBtn;
@property (nonatomic, strong) IquorButton *qqBtn;
@property (nonatomic, assign) BOOL isSession;  //好友

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(dismissController)];
    [self.view addGestureRecognizer:tapGes];
    [self setLayoutSubviews];
}


- (void)setLayoutSubviews {
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleLab];
    [self.bottomView addSubview:self.weChatBtn];
    [self.bottomView addSubview:self.qqBtn];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(250);
    }];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.bottomView);
        make.height.mas_equalTo(88);
    }];
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
  
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(110);
        make.right.equalTo(self.bottomView.mas_right).offset(-50);
        make.top.equalTo(self.bottomView.mas_top).offset(110);
    }];
    [self.weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(110);
        make.left.equalTo(self.bottomView.mas_left).offset(50);
        make.top.equalTo(self.bottomView.mas_top).offset(110);
    }];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 85)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(self.view.frame), 85)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.titleLab.frame;
                                                         
    layer.strokeColor = UIColorFromRGB(0xE8F1F6).CGColor;
                                                         
    layer.path = bezierPath.CGPath;
    layer.lineWidth = 1;
    [self.titleLab.layer addSublayer:layer];
                        
}

- (void)dismissController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)shareWeChatSession:(BOOL)isQQ {
    
    self.isSession = YES;
    [self startShare];
    [self dismissController];
}

- (void)shareWeChatTimeline:(BOOL)isSession {
  
    self.isSession = NO;
    [self startShare];
    [self dismissController];
}
- (void)startShare {
    NSArray* imageArray = @[[UIImage imageNamed:@"AppIcon"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"一款在线购物平台，随时查看订单交易状态。"
                                         images:imageArray
                                            url:[NSURL URLWithString:[IQourUser shareInstance].share_url]
                                          title:@"云聆汇"
                                           type:SSDKContentTypeAuto];
        
        // 有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        
        SSDKPlatformType platformType = self.isSession?SSDKPlatformSubTypeWechatSession:SSDKPlatformSubTypeWechatTimeline;
        [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            if (state == SSDKResponseStateFail) {
                [Dialog popTextAnimation:@"分享失败"];
            }
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"分享到";
        _titleLab.textColor = UIColorFromRGB(0x1B1B1B);
        _titleLab.font = [UIFont systemFontOfSize:24];
    }
    return _titleLab;
}
- (IquorButton *)weChatBtn {
    if (!_weChatBtn) {
        _weChatBtn = [IquorButton buttonWithType:UIButtonTypeCustom];
        [_weChatBtn setImage:[UIImage imageNamed:@"share_01"] forState:UIControlStateNormal];
        [_weChatBtn addTarget:self action:@selector(shareWeChatSession:) forControlEvents:UIControlEventTouchUpInside];
        [_weChatBtn setTitle:@"微信好友" forState:UIControlStateNormal];
        [_weChatBtn setTitleColor:UIColorFromRGB(0x1b1b1b) forState:UIControlStateNormal];
        _weChatBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _weChatBtn.imageRect = CGRectMake(20, 0, 60, 60);
        _weChatBtn.titleRect = CGRectMake(18, 60, 100, 30);
    }
    return _weChatBtn;
}
- (IquorButton *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [IquorButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(shareWeChatTimeline:) forControlEvents:UIControlEventTouchUpInside];
        [_qqBtn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
        [_qqBtn setTitleColor:UIColorFromRGB(0x1b1b1b) forState:UIControlStateNormal];
        _qqBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _qqBtn.imageRect = CGRectMake(20, 0, 60, 60);
        _qqBtn.titleRect = CGRectMake(10, 60, 100, 30);
    }
    return _qqBtn;
}




@end
