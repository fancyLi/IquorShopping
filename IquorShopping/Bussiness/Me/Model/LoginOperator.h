//
//  LoginOperator.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginOperator : NSObject
singtonInterface

- (void)loginVC:(void(^)(BOOL isScu))complation;

- (void)ensconceLogin;
@end
