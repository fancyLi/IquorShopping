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
#import "PageDetailViewController.h"
@interface GoodsInfoViewController ()
@property (nonatomic, strong) GoodsDetailViewController *detailVC;
@property (nonatomic, strong) AssessViewController *assessVC;
@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultConfig];

}

- (void)refreshCurrentViewController:(NSNotification*)noti {
    
    self.selectIndex = 1;
}
- (void)defaultConfig {
    self.showOnNavigationBar = YES;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressViewIsNaughty = NO;
    self.progressWidth = 28;
    self.progressViewCornerRadius = 1.5;
    self.progressHeight = 3;
    
    self.progressColor = [UIColor c_cc0Color];
    self.titleColorNormal = [UIColor c_333Color];
    self.titleColorSelected = [UIColor c_cc0Color];
    self.menuItemWidth = kMainScreenWidth/5.0;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.menuView.progressViewBottomSpace = 11;
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
    switch (index) {
        case 0:
            return self.detailVC;
            break;
        case 1:{
            PageDetailViewController *vc = [[PageDetailViewController alloc]init];
            vc.goods_detail = self.detailVC.goods_detail;
            return vc;
        }
            break;
        case 2:
            return self.assessVC;
            break;
            
        default:
            break;
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

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
}
#pragma mark set & get
- (GoodsDetailViewController *)detailVC {
    if (!_detailVC) {
        _detailVC = [[GoodsDetailViewController alloc]init];
        _detailVC.goods_id = self.goods_id;
    }
    return _detailVC;
}
- (AssessViewController *)assessVC {
    if (!_assessVC) {
        _assessVC = [[AssessViewController alloc]init];
        _assessVC.goods_id = self.goods_id;
    }
    return _assessVC;
}
@end
