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
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesClick:)];
    [self.leftContainer addGestureRecognizer:tapGes];
    [self.rightContainer addGestureRecognizer:tapGes];
    
}

- (void)tapGesClick:(UITapGestureRecognizer *)tapGes {
    NSInteger tag = tapGes.view.tag;
    if (tag == 1000) {
        self.priceSort = [self.priceSort isEqualToString:@"1"]?@"2":@"1";
        self.leftIcon.image = [UIImage imageNamed:[self.priceSort isEqualToString:@"1"]?@"icon_13":@"icon_14"];
    }else {
        self.volumeSort = [self.volumeSort isEqualToString:@"1"]?@"2":@"1";
        self.rightIcon.image = [UIImage imageNamed:[self.volumeSort isEqualToString:@"1"]?@"icon_13":@"icon_14"];
    }
    WeakObj(self);
    if (self.segmentSelectedBlock) {
        self.segmentSelectedBlock(selfWeak.priceSort, selfWeak.volumeSort);
    }
}

- (void)drawRect:(CGRect)rect {
    self.frame = CGRectMake(0, 64, kMainScreenWidth, 44);
}


@end
