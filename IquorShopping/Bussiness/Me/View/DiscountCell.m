//
//  DiscountCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DiscountCell.h"
#import "DiscountModel.h"
@interface DiscountCell ()
@property (weak, nonatomic) IBOutlet UIImageView *containerBG;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@end

@implementation DiscountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.actionBtn.layer.cornerRadius = 13;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)configDiscountCell:(DiscountModel *)model {
    if ([model.act isEqualToString:@"1"]) {
    }else {
        [self.actionBtn setTitle:@"已失效" forState:UIControlStateNormal];
        [self.actionBtn setTitleColor:[UIColor c_000color] forState:UIControlStateNormal];
        self.actionBtn.backgroundColor = UIColorFromRGB(0xb3b3b3);
        self.actionBtn.userInteractionEnabled = NO;
    }
    self.price.text = model.money;
    self.des.text = model.act_name;
    self.time.text = [NSString stringWithFormat:@"%@-%@", @"", @""];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
