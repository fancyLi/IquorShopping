//
//  VIPLevelCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "VIPLevelCell.h"
@interface VIPLevelCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
@implementation VIPLevelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setVip:(VIPLevel *)vip {
    _vip = vip;
    self.title.text = _vip.grade_name;
    self.subtitle.text = _vip.grade_text;
    self.price.text = [NSString stringWithFormat:@"￥%@", _vip.grade_money];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
