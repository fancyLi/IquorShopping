//
//  DiscountCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@end
