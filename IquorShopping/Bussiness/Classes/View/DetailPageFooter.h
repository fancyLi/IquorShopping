//
//  DetailPageFooter.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock)(NSInteger index);
@interface DetailPageFooter : UIView
@property (nonatomic, copy) ButtonClickBlock buttonClickBlock;
@end
