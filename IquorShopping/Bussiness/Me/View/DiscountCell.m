//
//  DiscountCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DiscountCell.h"

@implementation DiscountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.actionBtn.layer.cornerRadius = 13;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
