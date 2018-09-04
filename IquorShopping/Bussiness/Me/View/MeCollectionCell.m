//
//  MeCollectionCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeCollectionCell.h"

@implementation MeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.operatorBtn.layer.cornerRadius = 15;
    
    
    // Initialization code
}
- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.container.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.frame = self.container.bounds;
    layer.path = path.CGPath;
    self.container.layer.mask = layer;
}
- (IBAction)buttonClick:(id)sender {
    if (self.operatorCellBlock) {
        self.operatorCellBlock();
    }
}

@end
