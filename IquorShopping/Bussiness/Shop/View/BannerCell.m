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
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"http://chengchuan.ahaiba.com.cn/index.php",banner.banner];
    [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
