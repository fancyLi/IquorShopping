//
//  CollectedCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
typedef void (^ChoseCollectBlock)(BOOL sel);
@interface CollectedCell : UITableViewCell

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, strong) CollectModel *collect;
@property (nonatomic, copy) ChoseCollectBlock choseCollectBlock;

@end
