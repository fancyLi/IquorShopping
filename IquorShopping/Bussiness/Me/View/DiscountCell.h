//
//  DiscountCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OperatorButtonBlock)(void);
@class DiscountModel;
@interface DiscountCell : UITableViewCell

@property (nonatomic, copy) OperatorButtonBlock operatorButtonBlock;

- (void)configDiscountCell:(DiscountModel *)model;

- (void)configPreviewCell:(DiscountModel *)model;
@end
