//
//  ShopConfigCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassInfoModel.h"

@class GoodsArea;

@interface ShopConfigCell : UITableViewCell

@property (nonatomic, strong) NSArray <GoodsArea *> *areas;
@property (nonatomic, copy) void(^selectPrefecture)(GoodsArea *prefecture);

@end
