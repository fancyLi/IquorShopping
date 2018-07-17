//
//  MeCollectionReusableView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/3.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OperatorCellBlock)(void);
@interface MeCollectionReusableView : UICollectionReusableView
@property (nonatomic, copy) OperatorCellBlock operatorCellBlock;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *indicate;

@end

