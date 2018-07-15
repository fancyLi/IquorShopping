//
//  AddressInfoCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/5.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OperatorAddressBlock)(void);
@interface AddressInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftTitel;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, copy) OperatorAddressBlock operatorAddressBlock;

@end
