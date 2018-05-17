//
//  NavSearchBar.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NavSearchBar.h"

@interface NavSearchBar ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end


@implementation NavSearchBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.searchText.delegate = self;
}


#pragma mark UITextViewDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}


@end
