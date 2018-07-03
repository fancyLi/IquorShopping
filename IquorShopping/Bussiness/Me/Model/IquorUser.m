//
//  IquorUser.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/1.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorUser.h"

static IquorUser *_user;

@implementation IquorUser

+ (instancetype)shareIquorUser {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_user == nil) {
            _user = [[IquorUser alloc]init];
        }
    });
    return _user;
}
@end
