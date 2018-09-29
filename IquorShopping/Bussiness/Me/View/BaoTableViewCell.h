//
//  BaoTableViewCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/12.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaoTableViewCell;
typedef void (^OperatorBaoCellBlock)(BOOL sel, BaoTableViewCell *cell);
@interface BaoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *operatorBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (nonatomic, copy) OperatorBaoCellBlock operatorBaoCellBlock;
@end
