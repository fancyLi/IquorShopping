//
//  UITableViewCell+Layout.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "UITableViewCell+Layout.h"

@implementation UITableViewCell (Layout)
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
