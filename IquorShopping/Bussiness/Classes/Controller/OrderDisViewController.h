//
//  OrderDisViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"
#import "DiscountModel.h"

typedef void (^OperatorOrderBlock)(DiscountModel *discount);
@interface OrderDisViewController : IquorViewController
@property (nonatomic, copy) NSString *order_amount;
@property (nonatomic, copy) OperatorOrderBlock operatorOrderBlock;
@end
