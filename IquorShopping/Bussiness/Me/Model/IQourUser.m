//
//  IQourUser.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IQourUser.h"


@implementation IQourUser

singtonImplement(IQourUser)

- (void)save {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"pdUser"];
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
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pdUser"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tel"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pwd"];
}
+ (instancetype)userDefaultUnarchiver {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"pdUser"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self yy_modelInitWithCoder:aDecoder];
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}


@end
