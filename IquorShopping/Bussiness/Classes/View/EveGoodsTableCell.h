//
//  EveGoodsTableCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndentModel.h"
@interface EveGoodsTableCell : UITableViewCell

- (void)configCell:(IndentGoods *)indentGoods orderInfo:(OrderInfo *)order;

@end
