//
//  DetailPageFooter.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DetailPageFooter.h"
#import "IquorButton.h"

@interface DetailPageFooter ()

@property (weak, nonatomic) IBOutlet IquorButton *colButton;
@property (weak, nonatomic) IBOutlet IquorButton *cartButton;
@property (weak, nonatomic) IBOutlet IquorButton *serButton;

@end
@implementation DetailPageFooter

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat h = self.colButton.frame.size.height;
    CGFloat w = self.colButton.frame.size.width;
    self.colButton.titleRect = CGRectMake(0, 0.5*h, w, 0.4*h);
    self.colButton.imageRect = CGRectMake((w-20)/2.0, h*0.1, 20, 20);
    self.colButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.cartButton.titleRect = CGRectMake(0, 0.5*h, w, 0.4*h);
    self.cartButton.imageRect = CGRectMake((w-20)/2.0, h*0.1, 20, 20);
    self.cartButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.serButton.titleRect = CGRectMake(0, 0.5*h, w, 0.4*h);
    self.serButton.imageRect = CGRectMake((w-20)/2.0, h*0.1, 20, 20);
    self.serButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender.tag-1000);
    }
}

- (void)setIsCol:(BOOL)isCol {
    _isCol = isCol;
    if (_isCol) {
        [self.colButton setImage:[UIImage imageNamed:@"icon_21"] forState:UIControlStateNormal];
    }else {
        [self.colButton setImage:[UIImage imageNamed:@"icon_20"] forState:UIControlStateNormal];
    }
    
}
@end
