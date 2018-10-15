//
//  OrderModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OrderGoods : NSObject
//@property (nonatomic, copy) NSString *cart_id;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *attribute_value;

@property (nonatomic, copy) NSString *area_id;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, copy) NSString *discount_money;
@property (nonatomic, assign) BOOL is_discount;

@end

@interface Coupon : NSObject
@property (nonatomic, copy) NSString *ucid;
@property (nonatomic, copy) NSString *money;
@end


@interface OrderAdress : NSObject
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *contact_name;
@property (nonatomic, copy) NSString *contact_tel;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *district_name;
@property (nonatomic, copy) NSString *contact_addr;
@property (nonatomic, copy) NSString *defaultstr;
@end

@interface OrderModel : NSObject
@property (nonatomic, strong) NSArray<OrderGoods*> *goods_list;
@property (nonatomic, strong) NSArray<Coupon*> *coupon;
@property (nonatomic, strong) OrderAdress *addr;
//@property (nonatomic, strong) NSString *discount;
//@property (nonatomic, strong) NSString *is_discount;
@property (nonatomic, strong) NSString *discount_total;
@end
