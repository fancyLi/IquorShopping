//
//  IndentDetailCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "IndentModel.h"
@interface IndentDetailCell : UITableViewCell
@property (nonatomic, strong) OrderGoods *order;
@property (nonatomic, strong) IndentGoods *indent;
@property (nonatomic, strong) IndentGoods *orderIndent;
@end

