//
//  BlanceBeforeModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BlanceBeforeModel.h"

@implementation BlanceBeforeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"balance" : @"user_info.balance",
             @"alipay_account" : @"alipay_info.alipay_account",
             @"user_bank_id": @"bank_info.user_bank_id",
             @"bank_name": @"bank_info.bank_name"
             };
}
@end
