//
//  ShopTableHeaderView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
typedef void (^JCBannerViewBlock)(NSDictionary *data);

@interface ShopTableHeaderView : UIView
@property (nonatomic, copy) NSArray<Banner *> *banners;

@property (nonatomic, strong) UIImage *placeholderImage;
@property (nonatomic, assign) BOOL hideTitleLabel; //default YES
@property (nonatomic, assign) NSInteger autoPlayingInterval; //default 0

@property (nonatomic, copy) JCBannerViewBlock seletedBlock;
- (void)reloadData;
@end
