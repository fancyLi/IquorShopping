//
//  DiscountModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/11.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountModel : NSObject

@property (nonatomic, copy) NSString *ucid;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *full_money;
@property (nonatomic, copy) NSString *begin_use_time;
@property (nonatomic, copy) NSString *end_use_time;
//优惠券状态(1.未使用2.已失效3.已使用)状态1去使用跳到首页，2和3背景直接变暗，不可操作
@property (nonatomic, copy) NSString *act;
@property (nonatomic, copy) NSString *act_name;
@property (nonatomic, copy) NSString *is_page;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *msg;

@end
