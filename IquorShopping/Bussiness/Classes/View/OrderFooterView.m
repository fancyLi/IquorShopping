//
//  OrderFooterView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/20.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "OrderFooterView.h"

@implementation OrderFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.layer.borderColor = [UIColor c_f6f6Color].CGColor;
    self.rightBtn.layer.cornerRadius = 5;
}
- (IBAction)leftButtonClick:(UIButton *)sender {
    if (self.orderFooterBlock) {
        self.orderFooterBlock(sender.tag);
    }
}

- (IBAction)rightButtonClick:(UIButton *)sender {
    if (self.orderFooterBlock) {
        self.orderFooterBlock(sender.tag);
    }
}

@end
