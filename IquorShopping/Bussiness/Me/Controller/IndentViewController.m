//
//  IndentViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentViewController.h"
#import "YSLContainerViewController.h"
#import "IndentListViewController.h"
#import "WMPageController.h"
#import "WMMenuView.h"
@interface IndentViewController ()<WMPageControllerDelegate, WMPageControllerDataSource>
@property (nonatomic, strong) WMPageController *pageController;
@end

@implementation IndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"我的订单";
    
    [self.view addSubview:self.pageController.view];
    [self addChildViewController:self.pageController];
}
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 5;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index % 3) {
        case 0: return @"全部";
        case 1: return @"待付款";
        case 2: return @"待发货";
        case 3: return @"待收货";
        case 4: return @"待评价";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    IndentListViewController *vc = [[IndentListViewController alloc]init];
    switch (index) {
        case 0:
            vc.order_type = @"1";
            break;
        case 1:
            vc.order_type = @"2";
            break;
        case 2:
            vc.order_type = @"3";
            break;
        case 3:
            vc.order_type = @"4";
            break;
        case 4:
            vc.order_type = @"5";
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
    
    return CGRectMake(0, kTopHeight, kMainScreenWidth, 45);
    
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
        _pageController.menuItemWidth = kMainScreenWidth/5.0;
        _pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        _pageController.menuView.progressViewBottomSpace = 11;
    }
    return _pageController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
