//
//  ClassCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icon.layer.cornerRadius = 30;
    self.icon.layer.borderColor = [UIColor c_f6f6Color].CGColor;
    self.icon.layer.borderWidth = 1;
    self.icon.clipsToBounds = YES;
   
}

- (void)setClassInfo:(ClassInfoModel *)model {
    if (model.isOrgin) {
        self.icon.image = [UIImage imageNamed:model.cat_image];
    }else {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.cat_image] placeholderImage:[UIImage imageNamed:@"icon_01"]];
    }
        self.name.text = model.cat_name;
}
@end
