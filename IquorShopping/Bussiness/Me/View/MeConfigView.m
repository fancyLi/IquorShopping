//
//  MeConfigView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/10.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeConfigView.h"
#import "MeConfigModel.h"

@interface MeConfigView ()
@end


@implementation MeConfigView
- (void)awakeFromNib {
    [super awakeFromNib];

}
- (void)setConfigModel:(MeConfigModel *)configModel {
   
    _configModel = configModel;
    self.icon.image = [UIImage imageNamed:_configModel.iconName];
    self.title.text = _configModel.decTitle;
}

@end
