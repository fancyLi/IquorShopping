//
//  IquorNavigationViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorNavigationViewController.h"

@interface IquorNavigationViewController ()

@end

@implementation IquorNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果现在push的不是栈顶控制器，那么久隐藏tabbar工具条
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
