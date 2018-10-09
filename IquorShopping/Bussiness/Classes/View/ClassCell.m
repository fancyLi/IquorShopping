//
//  ClassCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ClassCell.h"
#import "HomePageModel.h"
#import "ClassInfoModel.h"
@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.icon.layer.cornerRadius = 30;
    self.icon.layer.borderColor = [UIColor c_f6f6Color].CGColor;
    self.icon.layer.borderWidth = 1;
    self.icon.clipsToBounds = YES;
   
}

- (void)setPrefecture:(GoodsArea *)prefecture {
    _prefecture = prefecture;
    if (_prefecture.isOrgin) {
        self.icon.image = [UIImage imageNamed:_prefecture.area_image];
    }else {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:_prefecture.area_image] placeholderImage:[UIImage imageNamed:@"icon_01"]];
    }
    self.name.text = _prefecture.area_name;
}

- (void)setClassInfo:(ClassInfoModel *)classInfo {
    _classInfo = classInfo;
    if (_classInfo.isOrgin) {
        self.icon.image = [UIImage imageNamed:_classInfo.cat_image];
    }else {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:_classInfo.cat_image] placeholderImage:[UIImage imageNamed:@"icon_01"]];
    }
    self.name.text = _classInfo.cat_name;
}

@end
