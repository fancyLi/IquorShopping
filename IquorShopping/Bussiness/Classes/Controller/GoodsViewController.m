//
//  GoodsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsDetailViewController.h"
#import "AssessViewController.h"
#import "AssessCell.h"
#import "NavDetailBar.h"

@interface GoodsViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) GoodsDetailViewController *detailVC;
@property (nonatomic, strong) AssessViewController *assessVC;
@property (nonatomic, strong) NavDetailBar *navBar;
@property (nonatomic, strong) UIScrollView *srcContainer;
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self goodsConfigUI];
   
}

- (void)goodsConfigUI {
    self.navigationItem.titleView = self.navBar;
     [self.view addSubview:self.srcContainer];
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int pageNo= scrollView.contentOffset.x/scrollView.frame.size.width;
    self.navBar.secCurrent = pageNo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & get
- (GoodsDetailViewController *)detailVC {
    if (!_detailVC) {
        _detailVC = [[GoodsDetailViewController alloc]init];
        _detailVC.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    return _detailVC;
}
- (AssessViewController *)assessVC {
    if (!_assessVC) {
        _assessVC = [[AssessViewController alloc]init];
        _assessVC.view.frame = CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    return _assessVC;
}
- (NavDetailBar *)navBar {
    if (!_navBar) {
        _navBar = [[NSBundle mainBundle] loadNibNamed:@"NavDetailBar" owner:self options:nil].firstObject;
        WeakObj(self);
        _navBar.chosCurrent = ^(NSInteger secCurrent) {
            selfWeak.srcContainer.contentOffset = CGPointMake(selfWeak.view.bounds.size.width*secCurrent, 0);
        };
    }
    return _navBar;
}
- (UIScrollView *)srcContainer {
    if (!_srcContainer) {
        _srcContainer = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _srcContainer.contentSize = CGSizeMake(self.view.bounds.size.width*3, self.view.bounds.size.height);
        _srcContainer.showsHorizontalScrollIndicator = NO;
        _srcContainer.delegate = self;
        _srcContainer.pagingEnabled = YES;
        [_srcContainer addSubview:self.detailVC.view];
        [_srcContainer addSubview:self.assessVC.view];
    }
    return _srcContainer;
}
@end
