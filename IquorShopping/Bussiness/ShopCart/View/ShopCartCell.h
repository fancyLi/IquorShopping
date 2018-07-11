//
//  ShopCartCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"

typedef void (^ChoseCollectBlock)(BOOL sel);
typedef void (^OperatorCartNumBlock)(NSString *op, NSString *num);
@interface ShopCartCell : UITableViewCell
@property (nonatomic, copy) OperatorCartNumBlock operatorCartNumBlock;
@property (nonatomic, copy) ChoseCollectBlock choseCollectBlock;
@property (nonatomic, assign) BOOL refreshLayout;
@property (nonatomic, strong) CartModel *cart;
@end
