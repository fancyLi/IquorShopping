//
//  IQourUser.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IQourUser.h"


@implementation IQourUser

//singtonImplement(IQourUser)

static IQourUser *_shareInstance;
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YYCache *cache = [YYCache cacheWithName:APPCacheName];
        _shareInstance = (IQourUser *)[cache objectForKey:UserInfo];
        if (_shareInstance == nil) {
            _shareInstance = [[IQourUser alloc]init];
        }
    });
    return _shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _shareInstance = [super allocWithZone:zone];
    });
    return _shareInstance;
}
- (void)save {
    YYCache *cache = [YYCache cacheWithName:APPCacheName];
    [cache setObject:_shareInstance forKey:UserInfo];
}

- (void)clean {
    self.avatar = @"";
    self.user_name = @"";
    self.user_tel = @"";
    self.nick_name = @"";
    self.user_code = @"";
    self.uid = @"";
    self.is_code = @"";
    self.level = @"";
    self.level_name = @"";
    self.service_number = @"";
    self.tel = @"";
    self.pwd = @"";
    self.share_url = @"";
    YYCache *cache = [YYCache cacheWithName:APPCacheName];
    if ([cache containsObjectForKey:UserInfo]) {
        [cache removeObjectForKey:UserInfo];
    }
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}


@end
