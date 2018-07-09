//
//  CartModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartModel : NSObject
@property (nonatomic, copy) NSString *car_id;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *attribute_value;
@end
