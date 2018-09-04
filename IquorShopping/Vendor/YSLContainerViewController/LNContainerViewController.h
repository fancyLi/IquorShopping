//
//  LNContainerViewController.h
//  ContainerVC
//
//  Created by linan on 16/10/10.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LNContainerViewController : UIViewController

@property (nonatomic, strong, readonly) NSMutableArray *titles;
@property (nonatomic, strong, readonly) NSMutableArray *childControllers;


- (id)initWithControllers:(NSArray *)controllers
     parentViewController:(UIViewController *)parentViewController;
@end
