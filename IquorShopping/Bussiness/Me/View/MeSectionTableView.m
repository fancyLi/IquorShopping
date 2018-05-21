//
//  MeSectionTableView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeSectionTableView.h"

@interface MeSectionTableView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *idicateImage;
@property (weak, nonatomic) IBOutlet UIButton *subButton;


@end

@implementation MeSectionTableView

- (void)setSection:(NSInteger)section {
    if (section == 0) {
        self.subtitleLabel.hidden = NO;
        self.idicateImage.hidden = NO;
        self.subButton.hidden = NO;
    }else if (section == 1) {
        self.titleLabel.text = @"代理中心";
    }else if (section == 2) {
        self.titleLabel.text = @"我的服务";
    }
}
- (void)setLeftTitle:(NSString *)leftTitle {
    self.titleLabel.text = leftTitle;
}
- (void)setRightTitle:(NSString *)rightTitle {
    self.subtitleLabel.text = rightTitle;
    self.subtitleLabel.hidden = NO;
    self.idicateImage.hidden = NO;
    self.subButton.hidden = NO;
}

@end
