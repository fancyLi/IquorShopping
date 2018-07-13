//
//  BankUserViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"

@class BankModel;
typedef void (^OperatorUserBlock)(BankModel *bank);
@interface BankUserViewController : IquorViewController

@property (nonatomic, copy) OperatorUserBlock operatorUserBlock;

@end
