//
//  MeHeaderTableView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OperateType) {
    KLogin = 0,
    KJoin,
    KMeInfo
};
typedef void (^OnClickButton)(OperateType operate);

@interface MeHeaderTableView : UIView
@property (nonatomic, copy) OnClickButton clickButtonBlock;
@end
