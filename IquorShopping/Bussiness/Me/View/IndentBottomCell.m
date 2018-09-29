//
//  IndentBottomCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentBottomCell.h"

@interface IndentBottomCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeMsg;

@end



@implementation IndentBottomCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.textview.layer.borderColor = [UIColor c_f6f6Color].CGColor;
    self.textview.layer.borderWidth = 1;
    self.textview.delegate = self;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.placeMsg removeFromSuperview];
}

@end