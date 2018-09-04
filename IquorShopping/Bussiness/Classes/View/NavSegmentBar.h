//
//  NavSegmentBar.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SegmentSelectedBlock)(NSString *priceSort, NSString *volumeSort);
@interface NavSegmentBar : UIView
@property (nonatomic, copy) SegmentSelectedBlock segmentSelectedBlock;
@end
