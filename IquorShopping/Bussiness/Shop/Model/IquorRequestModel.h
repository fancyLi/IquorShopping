//
//  IquorRequestModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IquorRequestModel : NSObject

@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, copy) NSString *pay_scene;
@property (nonatomic, copy) NSString *order_type;  
@property (nonatomic, copy) NSString *addr_id;
@property (nonatomic, copy) NSString *goods_ids_nums;
@property (nonatomic, copy) NSString *goods_num;
@property (nonatomic, copy) NSString *ucid;
@property (nonatomic, copy) NSString *discount_money;
@property (nonatomic, copy) NSString *order_total;
@property (nonatomic, copy) NSString *message;

@end
