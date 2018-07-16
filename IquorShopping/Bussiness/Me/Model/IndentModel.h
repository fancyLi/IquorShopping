//
//  IndentModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfoModel.h"


@interface IndentGoods : NSObject
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *value_id;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *value_name;
@end

@interface IndentModel : NSObject
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *act;
@property (nonatomic, copy) NSString *order_actname;
@property (nonatomic, copy) NSString *order_eval;
@property (nonatomic, strong) NSArray<IndentGoods*> *goods_list;
@end
