//
//  ShopLoverCell.m
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopLoverCell.h"

#import "HomePageModel.h"

@interface ShopLoverCell ()
@property (weak, nonatomic) IBOutlet UIImageView *loverAvatar;

@property (weak, nonatomic) IBOutlet UILabel *loverName;

@property (weak, nonatomic) IBOutlet UILabel *loverMoney;

@property (weak, nonatomic) IBOutlet UILabel *donateTime;

@end

@implementation ShopLoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.loverAvatar.layer.cornerRadius = 25;
    self.loverAvatar.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setLover:(Lover *)lover {
    _lover = lover;
    [self.loverAvatar sd_setImageWithURL:[NSURL URLWithString:_lover.avatar]];
    self.loverName.text = _lover.user_name;
    self.loverMoney.text = _lover.money;
    self.donateTime.text = _lover.addtime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
