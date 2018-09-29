//
//  NavDetailBar.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ ChosCurrent) (NSInteger secCurrent);
@interface NavDetailBar : UIView
@property (nonatomic, assign) NSInteger secCurrent;
@property (nonatomic, copy) ChosCurrent chosCurrent;
@end
