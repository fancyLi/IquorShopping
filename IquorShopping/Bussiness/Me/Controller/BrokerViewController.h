//
//  BrokerViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"

typedef NS_ENUM(NSInteger, CapitalType) {
    KCommision =0,
    KBonus
};
@interface BrokerViewController : IquorViewController
@property (nonatomic, assign) CapitalType capital;
@end
