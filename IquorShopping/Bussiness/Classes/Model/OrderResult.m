//
//  OrderResult.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "OrderResult.h"

@implementation OrderResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"return_addr" : [AddressModel class]
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"order_id" : @"order_info.order_id"
             };
}
@end
