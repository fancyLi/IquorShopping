//
//  FooterTableView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "FooterTableView.h"

@implementation FooterTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.borderColor = [UIColor c_333Color].CGColor;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.clipsToBounds = YES;
    
    self.rightBtn.layer.cornerRadius = 5;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
