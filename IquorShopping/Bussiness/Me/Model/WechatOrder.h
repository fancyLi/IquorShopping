//
//  WechatOrder.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WechatOrder : NSObject
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, assign) UInt32 timestamp;

@end
