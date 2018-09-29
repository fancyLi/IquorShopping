//
//  PlayerViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface PlayerViewController ()
@property (nonatomic, strong) UIWebView *webview;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"走进我们";
    self.webview = [[UIWebView alloc]init];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.viderStr]]];
//    [self playerAudio];
    // Do any additional setup after loading the view.
}
- (void)setViderStr:(NSString *)viderStr {
    _viderStr = viderStr;
}
- (void)playerAudio {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:self.viderStr]];
    AVPlayerViewController * playerController = [[AVPlayerViewController alloc] init];
    playerController.player = player;
    playerController.videoGravity = AVLayerVideoGravityResizeAspect;
    playerController.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
    playerController.showsPlaybackControls = true;
    
    [self addChildViewController:playerController];
    playerController.view.translatesAutoresizingMaskIntoConstraints = true;    //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
    playerController.view.frame = self.view.bounds;
    [self.view addSubview:playerController.view];
    [playerController.player play];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
