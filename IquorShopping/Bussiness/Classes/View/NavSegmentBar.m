//
//  NavSegmentBar.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NavSegmentBar.h"

@interface NavSegmentBar ()
@property (nonatomic, copy) NSString *priceSort;
@property (nonatomic, copy) NSString *volumeSort;
@property (weak, nonatomic) IBOutlet UIView *leftContainer;
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;
@property (weak, nonatomic) IBOutlet UIView *rightContainer;
@property (weak, nonatomic) IBOutlet UILabel *rightTitle;

@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;

@end

@implementation NavSegmentBar


- (void)awakeFromNib {
    [super awakeFromNib];
    self.priceSort = @"1";
    self.volumeSort = @"1";
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLeftGesClick:)];
    UITapGestureRecognizer *rtapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRightGesClick:)];
    [self.leftContainer addGestureRecognizer:tapGes];
    [self.rightContainer addGestureRecognizer:rtapGes];
    
}
- (void)tapLeftGesClick:(UITapGestureRecognizer *)tapGes {
    self.leftTitle.textColor = [UIColor c_cc0Color];
    self.rightTitle.textColor = [UIColor c_333Color];
    self.volumeSort = @"";
    self.rightIcon.image = [UIImage imageNamed:@"icon_15"];
    self.priceSort = [self.priceSort isEqualToString:@"1"]?@"2":@"1";
    self.leftIcon.image = [UIImage imageNamed:[self.priceSort isEqualToString:@"1"]?@"icon_13":@"icon_14"];
    if (self.segmentSelectedBlock) {
        self.segmentSelectedBlock(self.priceSort, self.volumeSort);
    }
}
- (void)tapRightGesClick:(UITapGestureRecognizer *)tapGes {
    self.leftTitle.textColor = [UIColor c_333Color];
    self.rightTitle.textColor = [UIColor c_cc0Color];
    self.priceSort = @"";
    self.leftIcon.image = [UIImage imageNamed:@"icon_15"];
    self.volumeSort = [self.volumeSort isEqualToString:@"1"]?@"2":@"1";
    self.rightIcon.image = [UIImage imageNamed:[self.volumeSort isEqualToString:@"1"]?@"icon_13":@"icon_14"];
    if (self.segmentSelectedBlock) {
        self.segmentSelectedBlock(self.priceSort, self.volumeSort);
    }
}

- (void)drawRect:(CGRect)rect {
    self.frame = CGRectMake(0, 64, kMainScreenWidth, 44);
}


@end
