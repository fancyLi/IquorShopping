//
//  BankInfoViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"
#import "BankModel.h"

typedef void (^OperatorCellBlock)(BankModel *model);
@interface BankInfoViewController : IquorViewController
@property (nonatomic, strong) NSArray<BankModel*> *arrs;
@property (nonatomic, copy) OperatorCellBlock operatorCellBlock;
@end
