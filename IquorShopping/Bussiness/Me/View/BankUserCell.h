//
//  BankUserCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankModel.h"
@class BankUserCell;
typedef void (^OperatorUserCellBlock)(BOOL sel, BankUserCell *cell);
@interface BankUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *operatorBtn;
@property (nonatomic, strong) BankModel *bank;
@property (nonatomic, copy) OperatorUserCellBlock operatorUserCellBlock;
@end
