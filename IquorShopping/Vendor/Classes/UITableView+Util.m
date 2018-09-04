//
//  UITableView+Util.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/20.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "UITableView+Util.h"

@implementation UITableView (Util)
- (void)setTableBgViewWithCount:(NSInteger)count img:(NSString*)imageName msg:(NSString*)msg{
    if (count <= 0) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor clearColor];
        self.backgroundView = backView;
        
        UIImageView*backImageView = [[UIImageView alloc] init];
        backImageView.image = [UIImage imageNamed:imageName];
        backImageView.contentMode = UIViewContentModeScaleAspectFit;
        [backView addSubview:backImageView];
        
        UILabel*backLabel = [[UILabel alloc] init];
        backLabel.text = msg;
        backLabel.textAlignment = NSTextAlignmentCenter;
        backLabel.textColor = [UIColor c_666Color];;
        backLabel.minimumScaleFactor = 0.5;
        [backView addSubview:backLabel];
        
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(backView);
            make.centerY.equalTo(backView).offset(-50);
            make.height.mas_equalTo(94);
            make.width.mas_equalTo(124);
        }];
        [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(backView);
            make.top.mas_equalTo(backImageView.mas_bottom).offset(20);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(self).offset(-30);
        }];
    } else {
        self.backgroundView = nil;
    }
}

@end
