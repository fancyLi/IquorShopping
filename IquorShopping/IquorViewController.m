//
//  IquorViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"

@interface IquorViewController ()

@end

@implementation IquorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
//    if (@available(iOS 11.0, *)) {
//        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor c_333Color], NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor c_333Color], NSFontAttributeName: [UIFont systemFontOfSize:16]}
                                                          forState:UIControlStateNormal];
    
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



@end
