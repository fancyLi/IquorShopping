//
//  OrderDisCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "OrderDisCell.h"

@interface OrderDisCell ()
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end

@implementation OrderDisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setDiscount:(DiscountModel *)discount {
    _discount = discount;
    self.price.text = _discount.money;
    self.des.text = [NSString stringWithFormat:@"满%@减%@元券", _discount.full_money, _discount.money];
    self.time.text = [NSString stringWithFormat:@"%@-%@", _discount.begin_use_time, _discount.end_use_time];
}
- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.operatorButtonBlock) {
        self.operatorButtonBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
