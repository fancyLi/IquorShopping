//
//  MerchantCell.m
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MerchantCell.h"
#import "MerchantModel.h"

@interface MerchantCell ()
/**  */
@property (nonatomic, weak)IBOutlet UIImageView *merchantImage;
/**  */
@property (nonatomic, weak)IBOutlet UILabel *merchantName;
/**  */
@property (nonatomic, weak)IBOutlet UILabel *merchantsAddr;
@end

@implementation MerchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMerchant:(MerchantModel *)merchant {
    _merchant = merchant;
    [self.merchantImage sd_setImageWithURL:[NSURL URLWithString:_merchant.shop_image]];
    self.merchantName.text = _merchant.shop_name;
    self.merchantsAddr.text = _merchant.shop_addr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
