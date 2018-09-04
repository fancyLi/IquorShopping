//
//  CityModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/6.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "CityModel.h"
#import "AreaModel.h"


@implementation CityModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sub" : [AreaModel class]};
}
@end


@implementation provinceModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"sub" : [CityModel class]};
}
@end
