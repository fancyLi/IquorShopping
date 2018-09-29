//
//  BrokerCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BrokerCell.h"
#import "BrokerModel.h"
@interface BrokerCell ()
@property (weak, nonatomic) IBOutlet UILabel *brokerDes;
@property (weak, nonatomic) IBOutlet UILabel *brokerTime;
@property (weak, nonatomic) IBOutlet UILabel *brokerMoney;
@end
@implementation BrokerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configBrokerCell:(BrokerModel *)model {
    self.brokerMoney.text = [model.act isEqualToString:@"1"]?@"佣金收入":@"佣金提现";
    self.brokerDes.text = [NSString stringWithFormat:@"%@￥%@", model.act_symbol, model.money];
    self.brokerTime.text = model.addtime;
}

- (void)configBonusCell:(BrokerModel *)model {
    self.brokerMoney.text = [model.act isEqualToString:@"1"]?@"分红收入":@"分红提现";
    self.brokerDes.text = [NSString stringWithFormat:@"%@￥%@", model.act_symbol, model.money];
    self.brokerTime.text = model.addtime;
}

- (void)confiBlanceCell:(BrokerModel *)model {
    self.brokerMoney.text = model.act_name;
    self.brokerDes.text = [NSString stringWithFormat:@"%@￥%@", model.act_symbol, model.money];
    self.brokerTime.text = model.addtime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
