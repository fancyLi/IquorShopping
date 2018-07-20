//
//  IquorTabBarViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorTabBarViewController.h"
#import "IquorNavigationViewController.h"
#import "ShopViewController.h"
#import "JoinsViewController.h"
#import "ClassesViewController.h"
#import "ShopCartViewController.h"
#import "MeViewController.h"

#import <EAIntroView.h>

@interface IquorTabBarViewController ()<UITabBarControllerDelegate>
@property (strong, nonatomic) EAIntroView *intro;
@end

@implementation IquorTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LoginOperator shareInstance] ensconceLogin];
//    [self welcomeView];
    ShopViewController *home                 = [[ShopViewController alloc] init];
    IquorNavigationViewController *homeNav            = [[IquorNavigationViewController alloc] initWithRootViewController:home];
    homeNav.tabBarItem.title                   = @"商城";
    homeNav.tabBarItem.selectedImage           = [[UIImage imageNamed:@"icon_nav_001"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.image                   = [UIImage imageNamed:@"icon_nav_01"];
    
    JoinsViewController *catagory     = [[JoinsViewController alloc] init];
    IquorNavigationViewController *catagoryNav        = [[IquorNavigationViewController alloc] initWithRootViewController:catagory];
    catagoryNav.tabBarItem.title               = @"加盟";
    catagoryNav.tabBarItem.selectedImage       = [[UIImage imageNamed:@"icon_nav_002"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    catagoryNav.tabBarItem.image               = [UIImage imageNamed:@"icon_nav_02"];
    
    ClassesViewController *promotion       = [[ClassesViewController alloc] init];
    IquorNavigationViewController *promotionNav       = [[IquorNavigationViewController alloc] initWithRootViewController:promotion];
    promotionNav.tabBarItem.title              = @"分类";
    promotionNav.tabBarItem.selectedImage      = [[UIImage imageNamed:@"icon_nav_003"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    promotionNav.tabBarItem.image              = [UIImage imageNamed:@"icon_nav_03"];
    
    ShopCartViewController *shoppingCart = [[ShopCartViewController alloc] init];
    IquorNavigationViewController *shoppingCartNav    = [[IquorNavigationViewController alloc] initWithRootViewController:shoppingCart];
    shoppingCartNav.tabBarItem.title           = @"购物车";
    shoppingCartNav.tabBarItem.selectedImage   = [[UIImage imageNamed:@"icon_nav_004"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppingCartNav.tabBarItem.image           = [UIImage imageNamed:@"icon_nav_04"];
//    shoppingCartNav.tabBarItem.badgeValue = @"1";
    
    MeViewController *account           = [[MeViewController alloc] init];
    IquorNavigationViewController *accountNav         = [[IquorNavigationViewController alloc] initWithRootViewController:account];
    accountNav.tabBarItem.title                = @"我的";
    accountNav.tabBarItem.selectedImage        = [[UIImage imageNamed:@"icon_nav_005"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    accountNav.tabBarItem.image                = [UIImage imageNamed:@"icon_nav_05"];
    
    // 设置 tabbar 控制器
    self.viewControllers  = @[homeNav, catagoryNav, promotionNav, shoppingCartNav, accountNav];
//    self.tabBar.tintColor = THEME_RED;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - EAIntroView delegate
- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"introDidFinish callback");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
}

- (void)skipIntroduction {
    [self.intro hideWithFadeOutDuration:0.3];
}

#pragma mark - private methods
- (void)welcomeView {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        EAIntroPage *page1 = [EAIntroPage pageWithCustomViewFromNibNamed:@"GuideView0"];
        EAIntroPage *page2 = [EAIntroPage pageWithCustomViewFromNibNamed:@"GuideView1"];
        EAIntroPage *page3 = [EAIntroPage pageWithCustomViewFromNibNamed:@"GuideView2"];
        EAIntroPage *page4 = [EAIntroPage pageWithCustomViewFromNibNamed:@"GuideView3"];
        EAIntroPage *page5 = [EAIntroPage pageWithCustomViewFromNibNamed:@"GuideView4"];
        
        UIButton *skipButton = (UIButton *)[page5.customView viewWithTag:101];
        [skipButton addTarget:self action:@selector(skipIntroduction) forControlEvents:UIControlEventTouchUpInside];
        
        self.intro = [[EAIntroView alloc] initWithFrame:[UIScreen mainScreen].bounds andPages:@[page1, page2, page3, page4, page5]];
        self.intro.skipButton = nil;
        self.intro.pageControl.hidden = YES;
        self.intro.swipeToExit = NO;
        self.intro.hideOffscreenPages = YES;
        [self.intro setDelegate:self];
        [self.intro showInView:self.view animateDuration:0.3];
    }
}


@end
