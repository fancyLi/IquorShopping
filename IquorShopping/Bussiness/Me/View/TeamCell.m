//
//  TeamCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "TeamCell.h"
@interface TeamCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *des;
@end
@implementation TeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTeamer:(TeamerModel *)teamer {
    _teamer = teamer;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_teamer.avatar] placeholderImage:[UIImage imageNamed:@"icon_head_02"]];
    self.name.text = _teamer.user_name;
    self.des.text = _teamer.level_name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
