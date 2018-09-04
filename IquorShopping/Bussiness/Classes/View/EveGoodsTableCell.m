//
//  EveGoodsTableCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "EveGoodsTableCell.h"
@interface EveGoodsTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *operator;

@end
@implementation EveGoodsTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.operator.layer.cornerRadius = 5;
    // Initialization code
}
- (void)configCell:(IndentGoods *)indentGoods orderInfo:(OrderInfo *)order {
    [self.icon sd_setImageWithURL:[NSURL URLWithString:indentGoods.goods_image]];
    self.title.text = indentGoods.goods_name;
    self.des.text = [NSString stringWithFormat:@"规格：%@", indentGoods.value_name];
    self.price.text = [NSString stringWithFormat:@"￥%@", indentGoods.goods_price];
    
    if (order.act.intValue==4&&order.order_eval.intValue==1) {
        self.operator.enabled = YES;
        self.operator.backgroundColor = [UIColor c_cc0Color];
        [self.operator setTitle:@"评价" forState:UIControlStateNormal];
    }else {
        self.operator.backgroundColor = [UIColor grayColor];
        self.operator.enabled = NO;
    }
}


- (IBAction)startEve:(UIButton *)sender {
    if (self.operatorCellBlock) {
        self.operatorCellBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
