//
//  MeInfoTableViewCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeInfoTableViewCell.h"

#import "UIButton+IquorArea.h"


@implementation MeInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.shareBtn setEnlargeEdgeWithTop:10 left:0 bottom:10 right:0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
