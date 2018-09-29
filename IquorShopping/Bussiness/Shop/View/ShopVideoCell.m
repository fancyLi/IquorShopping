//
//  ShopVideoCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopVideoCell.h"

@interface ShopVideoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@end

@implementation ShopVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setVideo_img:(NSString *)video_img {
    [self.videoImage sd_setImageWithURL:[NSURL URLWithString:video_img] placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
