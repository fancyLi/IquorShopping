//
//  MeConfigView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/10.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeConfigModel;
@interface MeConfigView : UIView
@property (nonatomic, strong) MeConfigModel *configModel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
