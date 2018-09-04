//
//  OrderResult.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
@interface OrderResult : NSObject
@property (nonatomic, copy) NSString *service_number;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *order_total;
@property (nonatomic, strong) AddressModel *return_addr;
@end
