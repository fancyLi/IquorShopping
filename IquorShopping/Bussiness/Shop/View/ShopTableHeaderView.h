//
//  ShopTableHeaderView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
typedef void (^JCBannerViewBlock)(Banner *banner);

@interface ShopTableHeaderView : UIView
@property (nonatomic, copy) NSArray<Banner *> *banners;
@property (nonatomic, copy) JCBannerViewBlock seletedBlock;

@end
