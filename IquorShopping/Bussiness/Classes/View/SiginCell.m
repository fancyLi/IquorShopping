//
//  SiginCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "SiginCell.h"
@interface SiginCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@end
@implementation SiginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configGoodsInfo:(GoodsInfoModel *)model {
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:nil];
    self.goodsDes.text = model.goods_name;
    self.goodsPrice.text = model.goods_price;
}
@end
