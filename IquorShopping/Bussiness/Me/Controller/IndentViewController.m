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
@interface IndentViewController ()

@end

@implementation IndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"我的订单";
    
    IndentListViewController *allvc = [[IndentListViewController alloc]init];
    allvc.title = @"全部";
    
    IndentListViewController *awatfkvc = [[IndentListViewController alloc]init];
    awatfkvc.title = @"待付款";
    
    IndentListViewController *awatfhvc = [[IndentListViewController alloc]init];
    awatfhvc.title = @"待发货";
    
    IndentListViewController *awatshvc = [[IndentListViewController alloc]init];
    awatshvc.title = @"待收货";
    
    IndentListViewController *awatpjvc = [[IndentListViewController alloc]init];
    awatpjvc.title = @"待评价";
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[allvc, awatfkvc, awatfhvc, awatshvc,awatpjvc]
                                                                                        topBarHeight:0
                                                                                parentViewController:self];
    containerVC.menuItemTitleColor = [UIColor c_333Color];
    containerVC.menuItemSelectedTitleColor = [UIColor c_cc0Color];
    containerVC.menuIndicatorColor = [UIColor c_cc0Color];
    containerVC.menuBackGroudColor = [UIColor whiteColor];
    containerVC.menuItemFont = [UIFont fontWithName:@"Futura-Medium" size:14];
    
    [self.view addSubview:containerVC.view];
    
    [containerVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(84);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
