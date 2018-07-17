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

- (void)configDict:(NSDictionary *)dict {
    self.avatar = dict[@"avatar"];
    self.user_name = dict[@"user_name"];
    self.user_tel = dict[@"user_tel"];
    self.nick_name = dict[@"nick_name"];
    self.user_code = dict[@"user_code"];
    self.user_name = dict[@"uid"];
    self.nick_name = dict[@"level"];
    self.user_code = dict[@"level_name"];
    self.user_code = dict[@"service_number"];
}
@end
