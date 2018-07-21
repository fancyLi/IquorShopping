//
//  IndentModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsInfoModel.h"
#import "AddressModel.h"

@interface IndentGoods : NSObject
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *value_id;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *value_name;
@property (nonatomic, copy) NSString *goods_num;
@end


@interface OrderInfo : NSObject
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *act;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *coupon_money;
@property (nonatomic, copy) NSString *discount_money;
@property (nonatomic, copy) NSString *order_amount;
@property (nonatomic, copy) NSString *order_eval;
@property (nonatomic, copy) NSString *act_name;
@property (nonatomic, copy) NSString *pay_type_name;
@property (nonatomic, copy) NSString *pay_type;
@end


@interface IndentModel : NSObject
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *act;
@property (nonatomic, copy) NSString *order_actname;
@property (nonatomic, copy) NSString *order_eval;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, strong) OrderInfo *order_info;
@property (nonatomic, strong) AddressModel *order_addr;
@property (nonatomic, strong) NSArray<IndentGoods*> *goods_list;
@end
