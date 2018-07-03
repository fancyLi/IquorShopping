//
//  MePageCollectionViewCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/3.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MePageCollectionViewCell.h"

@interface MePageCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation MePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellModel:(MeConfigModel *)cellModel {
    self.icon.image = [UIImage imageNamed:cellModel.iconName];
    self.title.text = cellModel.decTitle;
}

@end
