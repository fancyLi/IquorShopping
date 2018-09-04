//
//  BannerCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BannerCell.h"
@interface BannerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@end
@implementation BannerCell

- (void)configCell:(Banner *)banner {
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:banner.banner]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
