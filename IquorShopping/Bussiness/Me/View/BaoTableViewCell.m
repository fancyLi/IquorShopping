//
//  BaoTableViewCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/12.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BaoTableViewCell.h"
@interface BaoTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *operatorBtn;


@end
@implementation BaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)operatorClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
