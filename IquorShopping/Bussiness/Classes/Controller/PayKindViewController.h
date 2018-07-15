//
//  PayKindViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"

typedef void (^OperatorPayCellBlock)(NSString *type);
@interface PayKindViewController : IquorViewController
@property (nonatomic, copy) OperatorPayCellBlock operatorPayCellBlock;
@property (nonatomic, copy) NSString *pay_scene;
@end
