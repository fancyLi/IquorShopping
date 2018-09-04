//
//  CartTextCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "CartTextCell.h"

@interface CartTextCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *cartTextview;
@property (weak, nonatomic) IBOutlet UILabel *tipLaber;

@end
@implementation CartTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cartTextview.delegate = self;
    self.cartTextview.layer.borderWidth = 1;
    self.cartTextview.layer.borderColor = [UIColor c_f1f1Color].CGColor;
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 0.5;
    [super setFrame:frame];
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.tipLaber.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}
- (void)textViewDidChange:(UITextView *)textView {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
