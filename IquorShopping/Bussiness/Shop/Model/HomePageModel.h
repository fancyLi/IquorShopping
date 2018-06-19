//
//  HomePageModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClassInfoModel, GoodsInfoModel;
@interface Banner : NSObject
@property (nonatomic, copy) NSString *banner_id;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *banner;
@property (nonatomic, copy) NSString *goods_id;
@end


@interface HomePageModel : NSObject
@property (nonatomic, strong) NSArray <Banner*> *banner_list;
@property (nonatomic, strong) NSArray <ClassInfoModel*> *goods_cat_list;
@property (nonatomic, strong) NSArray <GoodsInfoModel*> *hot_goods;
@property (nonatomic, strong) NSArray <GoodsInfoModel*> *goods_new;
@property (nonatomic, copy) NSString *video_url;
@end


