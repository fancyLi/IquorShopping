//
//  TeamsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "TeamsViewController.h"
#import "TeamViewController.h"
#import "WMPageController.h"
#import "WMMenuView.h"
@interface TeamsViewController ()<WMPageControllerDelegate, WMPageControllerDataSource>
@property (nonatomic, strong) WMPageController *pageController;

@end

@implementation TeamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的团队";
    
    [self.view addSubview:self.pageController.view];
    [self addChildViewController:self.pageController];
    
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"金牌团队";
        case 1: return @"银牌团队";
        case 2: return @"铜牌团队";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    TeamViewController *vc = [[TeamViewController alloc]init];
    switch (index) {
        case 0:
            vc.team_id = @"1";
            break;
        case 1:
            vc.team_id = @"2";
            break;
        case 2:
            vc.team_id = @"3";
            break;
        default:
            break;
    }
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [self menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0,0, kMainScreenWidth, 45);
    
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.pageController.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (WMPageController *)pageController {
    if (!_pageController) {
        _pageController = [WMPageController new];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.menuViewStyle = WMMenuViewStyleLine;
        _pageController.progressViewIsNaughty = NO;
        _pageController.progressWidth = 28;
        _pageController.progressViewCornerRadius = 1.5;
        _pageController.progressHeight = 3;
        
        _pageController.progressColor = [UIColor c_cc0Color];
        _pageController.titleColorNormal = [UIColor c_333Color];
        _pageController.titleColorSelected = [UIColor c_cc0Color];
        _pageController.menuItemWidth = kMainScreenWidth/3.0;
        _pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        _pageController.menuView.progressViewBottomSpace = 11;
    }
    return _pageController;
}
- (void)requestTeam {
//    [AFNetworkTool postJSONWithUrl:user_teamList parameters:nil success:^(id responseObject) {
//        NSInteger code = [responseObject[@"code"] integerValue];
//        
//        if (code == 200) {
//        }else {
//            [Dialog popTextAnimation:responseObject[@"message"]];
//        }
//    } fail:^{
//        
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
