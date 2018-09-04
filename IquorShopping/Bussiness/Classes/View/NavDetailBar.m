//
//  NavDetailBar.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NavDetailBar.h"

@interface NavDetailBar ()
{
    UIButton *_preBtn;
}
@property (weak, nonatomic) IBOutlet UIButton *goodsBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *critBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLeftConstraint;

@end

@implementation NavDetailBar

- (void)awakeFromNib {
    [super awakeFromNib];
    _preBtn = self.goodsBtn;
}
/**
 tag 1000|商品  1001|详情 1002|评价
 */
- (IBAction)choseSegment:(UIButton *)sender {
    [_preBtn setTitleColor:[UIColor c_666Color] forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor c_cc0Color] forState:UIControlStateNormal];
    _preBtn = sender;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLeftConstraint.constant = sender.frame.origin.x;
    } completion:^(BOOL finished) {
        if (self.chosCurrent) {
            self.chosCurrent(sender.tag-1000);
        }
    }];
}

- (void)setSecCurrent:(NSInteger)secCurrent {
   UIButton *sender = [self viewWithTag:1000+secCurrent];
    [self performSelector:@selector(choseSegment:) withObject:sender afterDelay:0];
}




@end
