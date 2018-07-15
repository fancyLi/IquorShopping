//
//  OrderModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderGoods

@end

@implementation Coupon

@end

@implementation OrderAdress
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"defaultstr"  : @"default"};
}
@end

@implementation OrderModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods_list" : [OrderGoods class],
             @"coupon": [Coupon class],
             @"addr": [OrderAdress class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"discount" : @"discount_info.discount",
             @"is_discount" : @"discount_info.is_discount"
             };
}
@end
