//
//  ClassCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsArea;
@class ClassInfoModel;

@interface ClassCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) GoodsArea *prefecture;
@property (nonatomic, strong) ClassInfoModel *classInfo;

@end
