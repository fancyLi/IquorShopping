//
//  ShopLoveCell.h
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Lover;
@class HomePageModel;

@interface ShopLoveCell : UITableViewCell

@property (nonatomic, strong) HomePageModel *homePage;

//更多
@property (nonatomic, copy) void (^moreDonate)(void);

@end
