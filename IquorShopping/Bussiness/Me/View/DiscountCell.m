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
    self.actionBtn.layer.cornerRadius = 15;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.actionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)sender {
    if (self.operatorButtonBlock) {
        self.operatorButtonBlock();
    }
}
- (void)configDiscountCell:(DiscountModel *)model {
    if ([model.act isEqualToString:@"1"]) {
        [self.actionBtn setTitle:@"去使用" forState:UIControlStateNormal];
        [self.actionBtn setTitleColor:[UIColor c_fb8a35Color] forState:UIControlStateNormal];
        self.actionBtn.backgroundColor = [UIColor whiteColor];
    }else {
        [self.actionBtn setTitle:@"已失效" forState:UIControlStateNormal];
        [self.actionBtn setTitleColor:[UIColor c_fbfbfbColor] forState:UIControlStateNormal];
        self.actionBtn.backgroundColor = UIColorFromRGB(0xb3b3b3);
        self.actionBtn.userInteractionEnabled = NO;
    }
    self.price.text = model.money;
    self.des.text = [NSString stringWithFormat:@"满%@减%@元券", model.full_money,model.money];
    self.time.text = [NSString stringWithFormat:@"%@-%@", model.begin_use_time, model.end_use_time];
}

- (void)configPreviewCell:(DiscountModel *)model {
    [self.actionBtn setTitle:@"领取" forState:UIControlStateNormal];
    self.price.text = model.money;
    self.des.text = [NSString stringWithFormat:@"满%@减%@元券", model.full_money, model.money];
    self.time.text = [NSString stringWithFormat:@"%@-%@", model.begin_use_time, model.end_use_time];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
