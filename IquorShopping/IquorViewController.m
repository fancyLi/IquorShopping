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
    
//    if (@available(iOS 11.0, *)) {
//        self.additionalSafeAreaInsets = UIEdgeInsetsMake(64, 0, 49, 0);
//        NSLog(@"---%f-%f",self.additionalSafeAreaInsets.top, self.additionalSafeAreaInsets.bottom);
//    } else {
//    }
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.view.backgroundColor = [UIColor c_f6f6Color];
    
//    if (@available(iOS 11.0, *)) {
//        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
//
    //设置toast样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor c_333Color], NSFontAttributeName: [UIFont systemFontOfSize:17]}];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
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

- (BOOL)isLogin {
    if ([IQourUser shareInstance].user_tel) {
        return YES;
    }else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"您尚未登录，是否现在登录" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        return NO;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
