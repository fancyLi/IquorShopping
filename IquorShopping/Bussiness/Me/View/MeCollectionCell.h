//
//  MeCollectionCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OperatorCellBlock)(void);
@interface MeCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UIButton *operatorBtn;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic, copy) OperatorCellBlock operatorCellBlock;

@end
