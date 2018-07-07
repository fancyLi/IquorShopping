//
//  DetailPageFooter.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DetailPageFooter.h"

@implementation DetailPageFooter

- (IBAction)btnClick:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender.tag-1000);
    }
}


@end
