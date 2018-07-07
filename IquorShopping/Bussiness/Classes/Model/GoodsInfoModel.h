//
//  GoodsInfoModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface GoodsInfoModel : NSObject
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *cat_info;
@property (nonatomic, copy) NSString *cat_id;
@property (nonatomic, copy) NSString *goods_sort;
@property (nonatomic, copy) NSString *isup;
@property (nonatomic, copy) NSString *attribute_id;
@property (nonatomic, copy) NSString *value_id;
@property (nonatomic, copy) NSString *sales_volume;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *hot;
@property (nonatomic, copy) NSString *sale_num;
@property (nonatomic, copy) NSString *tag_id;
@property (nonatomic, copy) NSString *goods_detail;
@property (nonatomic, copy) NSString *goods_new;
@property (nonatomic, strong) NSArray *goods_pics;
@property (nonatomic, strong) NSArray *tag_list;
@property (nonatomic, strong) NSArray <CommentModel *>*comment;
@property (nonatomic, copy) NSString *cat_name;
@property (nonatomic, copy) NSString *attr_name;
@property (nonatomic, copy) NSString *isCollect;

@end

//分类信息
@interface CatInfo: NSObject
@property (nonatomic, copy) NSString *cat_id;
@property (nonatomic, copy) NSString *cat_name;
@end

//分页信息
@interface PageInfo: NSObject
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *msg;
@end

// 所有信息
@interface AllInfo: NSObject
@property (nonatomic, strong) CatInfo *cat_info;
@property (nonatomic, strong) PageInfo *is_page;
@property (nonatomic, copy) NSString *key_words;
@property (nonatomic, strong) NSArray<GoodsInfoModel *> *list;
@end
