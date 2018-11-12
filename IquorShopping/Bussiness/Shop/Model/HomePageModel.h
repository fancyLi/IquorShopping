//
//  HomePageModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClassInfoModel, GoodsInfoModel;


/**
 轮播图
 */
@interface Banner : NSObject
@property (nonatomic, copy) NSString *banner_id;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *banner;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *isshow;
@end


/**
 关于我们
 */
@interface Video : NSObject
@property (nonatomic, copy) NSString *video_url;
@property (nonatomic, copy) NSString *video_img;
@end

/**
 专区
 */
@interface GoodsArea : NSObject
@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *area_image;
@property (nonatomic, assign) BOOL isOrgin;
@end



/**
 捐赠者
 */
@interface Lover : NSObject
@property (nonatomic, copy) NSString *love_id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *avatar;
@end

@interface HomePageModel : NSObject
@property (nonatomic, strong) NSArray <Banner*> *banner_list;
@property (nonatomic, strong) NSArray <Banner*> *love_banner;
@property (nonatomic, strong) NSArray <ClassInfoModel*> *goods_cat_list;
@property (nonatomic, strong) NSArray <GoodsInfoModel*> *goods_new;
@property (nonatomic, strong) NSArray <GoodsInfoModel*> *hot_goods;
@property (nonatomic, strong) NSArray <GoodsArea*> *goods_area_list;
@property (nonatomic, strong) NSArray <Lover*> *love_list;
@property (nonatomic, copy) NSString *total_giving;

@property (nonatomic, strong) Video *video;
@property (nonatomic, copy) NSString *isOpen;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end


//config
@interface HomePageModel (Config)
/**  */
@property (nonatomic, assign, readonly) CGFloat loveHeight;

@end


@interface LoverContent :NSObject
/**  */
@property (nonatomic, assign) double love_total;
/**  */
@property (nonatomic, strong) NSArray<Lover *> *list;
@end
