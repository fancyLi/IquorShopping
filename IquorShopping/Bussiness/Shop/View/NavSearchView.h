//
//  NavSearchView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OperatorSerachBlock)(void);
@interface NavSearchView : UIView
@property (nonatomic, copy) OperatorSerachBlock operatorSerachBlock;
@end
