//
//  AddGoodsViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"
#import "GoodsInfoModel.h"

typedef void (^OperatorBuyBlock)(void);
@interface AddGoodsViewController : IquorViewController
@property (nonatomic, strong) GoodsInfoModel *goodsInfo;
@property (nonatomic, assign) BOOL isCart;
@property (nonatomic, copy) OperatorBuyBlock operatorBuyBlock;
@end
