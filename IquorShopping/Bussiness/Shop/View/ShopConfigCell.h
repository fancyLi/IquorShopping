//
//  ShopConfigCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassInfoModel.h"
typedef void (^ConfigBlock)(void);
@interface ShopConfigCell : UITableViewCell

@property (nonatomic, copy) ConfigBlock configBlock;
- (void)configCatInfo:(NSArray <ClassInfoModel *>*)cats;
@end
