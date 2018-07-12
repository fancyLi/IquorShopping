//
//  BrokerCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrokerModel;
@interface BrokerCell : UITableViewCell


- (void)configBrokerCell:(BrokerModel *)model;

- (void)configBonusCell:(BrokerModel *)model;

- (void)confiBlanceCell:(BrokerModel *)model;

@end
