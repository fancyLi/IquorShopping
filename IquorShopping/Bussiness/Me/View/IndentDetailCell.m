//
//  IndentDetailCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentDetailCell.h"
@interface IndentDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *nums;

@end

@implementation IndentDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
- (void)setOrder:(OrderGoods *)order {
    _order = order;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_order.goods_image]];
    self.name.text = _order.goods_name;
//    self.des.text = [NSString stringWithFormat:@"规格%@", _order.attribute_value];
    self.price.text = [NSString stringWithFormat:@"￥%@", _order.goods_price];
    self.nums.text = [NSString stringWithFormat:@"x%@", _order.goods_num];
}

- (void)setIndent:(IndentGoods *)indent {
    _indent = indent;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_indent.goods_image]];
    self.name.text = _indent.goods_name;
    self.des.text = [NSString stringWithFormat:@"规格%@", _indent.value_name];
    self.price.text = [NSString stringWithFormat:@"￥%@", _indent.goods_price];
}
- (void)setOrderIndent:(IndentGoods *)orderIndent {
    _orderIndent = orderIndent;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_orderIndent.goods_image]];
    self.name.text = _orderIndent.goods_name;
    self.des.text = [NSString stringWithFormat:@"规格%@", _orderIndent.value_name];
    self.price.text = [NSString stringWithFormat:@"￥%@", _orderIndent.goods_price];
    self.nums.text = [NSString stringWithFormat:@"x%@", _orderIndent.goods_num];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
