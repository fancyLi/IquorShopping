//
//  BrokerModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/11.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrokerModel : NSObject
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *addtime;
//类型 (1.佣金收入2.佣金提现)
@property (nonatomic, copy) NSString *act;
@property (nonatomic, copy) NSString *act_name;
//类型符号( + 和 -)
@property (nonatomic, copy) NSString *act_symbol;
@property (nonatomic, copy) NSString *is_page;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *msg;
@end
