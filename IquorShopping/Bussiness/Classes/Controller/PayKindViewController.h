//
//  PayKindViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"
#import "OrderPay.h"
typedef void (^OperatorPayCellBlock)(OrderPay *orderPay);
@interface PayKindViewController : IquorViewController
@property (nonatomic, copy) OperatorPayCellBlock operatorPayCellBlock;
@property (nonatomic, copy) NSString *pay_scene;
@property (nonatomic, copy) NSString *curPay;
@end
