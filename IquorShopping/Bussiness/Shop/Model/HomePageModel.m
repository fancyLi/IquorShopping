//
//  HomePageModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "HomePageModel.h"
#import "ClassInfoModel.h"
#import "GoodsInfoModel.h"
@implementation Banner
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"banner_id"  : @"id"};
}
@end

@implementation Video

@end



@implementation HomePageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"goods_new"  : @"new_goods",
             @"video": @"walk_into_us",
             @"title":@"notice.title",
             @"content":@"notice.content"
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banner_list" : [Banner class],
             @"goods_cat_list" : [ClassInfoModel class],
             @"hot_goods": [GoodsInfoModel class],
             @"goods_new": [GoodsInfoModel class],
             @"video":[Video class]
             };
}
@end
