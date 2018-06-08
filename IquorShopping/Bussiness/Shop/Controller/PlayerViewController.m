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

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self playerAudio];
    // Do any additional setup after loading the view.
}
- (void)playerAudio {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:@"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
