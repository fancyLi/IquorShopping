//
//  SetViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "SetViewController.h"
#import "VersionViewController.h"
#import "FileUtils.h"
@interface SetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cache;
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UIView *cacheClear;
@property (weak, nonatomic) IBOutlet UIView *versionAbout;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSetUI];
    
}
- (void)configSetUI {
    self.title = @"个人设置";
    self.cache.text = [NSString stringWithFormat:@"%.2fM", [FileUtils calculateFolderSizeAtPath:NSHomeDirectory()]];
    self.version.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    UITapGestureRecognizer *tapClear = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clearCache)];
    [self.cacheClear addGestureRecognizer:tapClear];
    
    UITapGestureRecognizer *tapVersion = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(aboutVersion)];
    [self.versionAbout addGestureRecognizer:tapVersion];
}

- (void)clearCache {
    [FileUtils cleanCacheDataWithCachPath:NSHomeDirectory()];
    [Dialog popTextAnimation:@"缓存已清除"];
    self.cache.text = @"0.00M";
}
- (void)aboutVersion {
    VersionViewController *versionVC = [[VersionViewController alloc]init];
    [self.navigationController pushViewController:versionVC animated:YES];
}
- (IBAction)exitClick:(id)sender {
    
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
