//
//  LoginViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"

typedef void (^LoginOperatorBlock)(BOOL isScu);
@interface LoginViewController : IquorViewController
@property (nonatomic, copy) LoginOperatorBlock loginOperatorBlock;
@end
