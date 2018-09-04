//
//  OrderDisCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountModel.h"

typedef void (^OperatorButtonBlock)(void);
@interface OrderDisCell : UITableViewCell
@property (nonatomic, strong) DiscountModel *discount;
@property (nonatomic, copy) OperatorButtonBlock operatorButtonBlock;
@property (weak, nonatomic) IBOutlet UIButton *selButton;
@end
