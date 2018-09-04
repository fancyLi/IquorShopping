//
//  OrderFooterView.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/20.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^OrderFooterBlock)(NSInteger tag);
@interface OrderFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic, copy) OrderFooterBlock orderFooterBlock;
@end
