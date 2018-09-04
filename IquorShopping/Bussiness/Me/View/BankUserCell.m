//
//  BankUserCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/13.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BankUserCell.h"
@interface BankUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *count;


@end
@implementation BankUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setBank:(BankModel *)bank {
    _bank = bank;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_bank.bank_pic] placeholderImage:nil];
    self.name.text = _bank.bank_name;
    self.count.text = [NSString stringWithFormat:@"尾号%@", _bank.bank_account];
}
- (IBAction)startOperator:(UIButton *)sender {
    sender.selected = !self.selected;
    if (self.operatorUserCellBlock) {
        self.operatorUserCellBlock(sender.selected, self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
