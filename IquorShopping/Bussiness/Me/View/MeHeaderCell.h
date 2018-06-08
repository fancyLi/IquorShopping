//
//  MeHeaderCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangeAvator)(void);
@interface MeHeaderCell : UITableViewCell
@property (nonatomic, copy) ChangeAvator changeAvatorBlock;
@property (weak, nonatomic) IBOutlet UIButton *headerImg;

@end
