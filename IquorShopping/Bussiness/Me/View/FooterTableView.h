//
//  FooterTableView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OperatorBlock)(BOOL isLeft);
@interface FooterTableView : UIView
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (nonatomic, copy) OperatorBlock operatorBlock;

@end
