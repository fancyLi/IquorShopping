//
//  OrderPay.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPay : NSObject
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *isshow;
@property (nonatomic, assign) BOOL isScu;
@end
