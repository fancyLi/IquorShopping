//
//  NavSearchView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NavSearchView.h"

@interface NavSearchView ()
@property (weak, nonatomic) IBOutlet UIView *searchView;

@end
@implementation NavSearchView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(startSerach)];
    [self.searchView addGestureRecognizer:tapGes];
}
- (IBAction)startSearch:(id)sender {
    if (self.operatorSerachBlock) {
        self.operatorSerachBlock();
    }
}

- (void)startSerach {
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
