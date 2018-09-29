//
//  BankModel.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"bank_id" : @"user_bank_id"
             };
}
@end
