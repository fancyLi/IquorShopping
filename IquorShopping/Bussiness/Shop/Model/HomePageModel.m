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

@implementation Lover

@end


@implementation GoodsArea

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
             @"video":[Video class],
             @"love_list": [Lover class],
             @"love_banner":[Banner class],
             @"goods_area_list":[GoodsArea class]
             };
}
@end

@implementation HomePageModel (Config)

- (CGFloat)loveHeight {
    CGFloat h = 0.0;
    if (self.love_banner.count) {
        h += 100;
    }
    if (self.love_list.count && self.love_list.count>=3) {
        h += 60*5;
    }else if (self.love_list.count && self.love_list.count < 3) {
        h += 60*(self.love_list.count+2);
    }
    return h;
}

@end


@implementation LoverContent

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [Lover class]
             };
}
@end
