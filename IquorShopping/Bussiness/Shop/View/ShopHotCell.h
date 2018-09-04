//
//  ShopHotCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsInfoModel.h"

typedef void (^OperatorHotCellBlock)(GoodsInfoModel *model);
typedef void (^OperatorHotLookBlock)(void);
@interface ShopHotCell : UITableViewCell
@property (nonatomic, copy) OperatorHotCellBlock operatorHotCellBlock;
@property (nonatomic, copy) OperatorHotLookBlock operatorHotLookBlock;
- (void)configHotInfo:(NSArray <GoodsInfoModel *>*)hotGoods;

@end
