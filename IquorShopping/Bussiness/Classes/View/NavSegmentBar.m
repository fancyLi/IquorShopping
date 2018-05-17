//
//  NavSegmentBar.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NavSegmentBar.h"

@interface NavSegmentBar ()
@property (weak, nonatomic) IBOutlet UIView *leftContainer;
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;
@property (weak, nonatomic) IBOutlet UIView *rightContainer;
@property (weak, nonatomic) IBOutlet UILabel *rightTitle;

@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;

@end

@implementation NavSegmentBar



- (void)drawRect:(CGRect)rect {
    self.frame = CGRectMake(0, 64, kMainScreenWidth, 44);
}


@end
