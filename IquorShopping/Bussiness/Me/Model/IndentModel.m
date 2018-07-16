//
//  IndentModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentModel.h"
@implementation IndentGoods

@end


@implementation IndentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goods_list" : [IndentGoods class]
             };
}
@end
