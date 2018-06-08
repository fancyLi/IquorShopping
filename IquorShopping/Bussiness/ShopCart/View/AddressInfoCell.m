//
//  AddressInfoCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/5.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AddressInfoCell.h"

@implementation AddressInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
