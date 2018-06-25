//
//  ShopNewCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsInfoModel.h"
@interface ShopNewCell : UITableViewCell
- (void)configNewInfo:(NSArray <GoodsInfoModel *>*)goodsNew;
- (CGFloat)getCellHeight:(NSArray <GoodsInfoModel *>*)goodsNew;

@end
