//
//  BrokerCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *brokerDes;
@property (weak, nonatomic) IBOutlet UILabel *brokerTime;
@property (weak, nonatomic) IBOutlet UILabel *brokerMoney;

@end
