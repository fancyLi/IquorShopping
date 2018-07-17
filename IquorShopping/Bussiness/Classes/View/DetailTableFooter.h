//
//  DetailTableFooter.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FooterBlock)(CGFloat height);
@interface DetailTableFooter : UIView
@property (nonatomic, copy) NSString *frament;
@property (nonatomic, copy) FooterBlock footerBlock;
@end
