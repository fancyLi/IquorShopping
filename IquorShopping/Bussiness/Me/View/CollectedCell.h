//
//  CollectedCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chosBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
