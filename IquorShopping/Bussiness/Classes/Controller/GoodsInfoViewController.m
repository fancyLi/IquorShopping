//
//  GoodsInfoViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/3.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "GoodsDetailViewController.h"
#import "AssessViewController.h"

@interface GoodsInfoViewController ()
@property (nonatomic, strong) GoodsDetailViewController *detailVC;
@property (nonatomic, strong) AssessViewController *assessVC;
@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultConfig];

}

- (void)defaultConfig {
    self.showOnNavigationBar = YES;
    self.menuViewStyle = WMMenuViewStyleLine;
}
//设置导航栏返回按钮
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_back_02"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index % 3) {
        case 0: return @"商品";
        case 1: return @"详情";
        case 2: return @"评价";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index % 3) {
        case 0: return self.detailVC;
        case 1: return [[UIViewController alloc] init];
        case 2: return self.assessVC;
    }
    return [[UIViewController alloc] init];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
   
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}


#pragma mark set & get
- (GoodsDetailViewController *)detailVC {
    if (!_detailVC) {
        _detailVC = [[GoodsDetailViewController alloc]init];
        _detailVC.goodsInfo = self.goodsInfo;
    }
    return _detailVC;
}
- (AssessViewController *)assessVC {
    if (!_assessVC) {
        _assessVC = [[AssessViewController alloc]init];
    }
    return _assessVC;
}
@end
