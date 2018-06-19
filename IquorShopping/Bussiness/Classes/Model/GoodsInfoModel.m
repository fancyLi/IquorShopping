//
//  GoodsInfoModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "GoodsInfoModel.h"

@implementation GoodsInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goods_new"  : @"new"};
}
@end



@implementation AllInfo
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [GoodsInfoModel class]
             };
}
@end

@implementation PageInfo

@end

@implementation CatInfo

@end
