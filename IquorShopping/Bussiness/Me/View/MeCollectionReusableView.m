//
//  MeCollectionReusableView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/3.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeCollectionReusableView.h"

@interface MeCollectionReusableView ()

@end
@implementation MeCollectionReusableView
- (IBAction)buttonClick:(id)sender {
    if (self.operatorCellBlock) {
        self.operatorCellBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
