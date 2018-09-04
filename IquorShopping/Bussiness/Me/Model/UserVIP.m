//
//  UserVIP.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "UserVIP.h"

@implementation VIPLevel

@end

@implementation UserVIP
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"up_grade" : [VIPLevel class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"interests"  : @"grade.interests"};
}
@end
