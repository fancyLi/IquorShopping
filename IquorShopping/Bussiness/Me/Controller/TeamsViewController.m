//
//  TeamsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "TeamsViewController.h"
#import "YSLContainerViewController.h"
#import "TeamViewController.h"
@interface TeamsViewController ()

@end

@implementation TeamsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的团队";
    
    TeamViewController *allvc = [[TeamViewController alloc]init];
    allvc.title = @"金牌团队";
    
    TeamViewController *awatfkvc = [[TeamViewController alloc]init];
    awatfkvc.title = @"银牌团队";
    
    TeamViewController *awatfhvc = [[TeamViewController alloc]init];
    awatfhvc.title = @"铜牌团队";
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[allvc, awatfkvc, awatfhvc]
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
