//
//  IndentBottomCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentBottomCell.h"

@interface IndentBottomCell ()
@property (weak, nonatomic) IBOutlet UILabel *ddbh;
@property (weak, nonatomic) IBOutlet UILabel *wldh;
@property (weak, nonatomic) IBOutlet UILabel *xdsj;
@property (weak, nonatomic) IBOutlet UILabel *zffs;
@property (weak, nonatomic) IBOutlet UILabel *yhq;
@property (weak, nonatomic) IBOutlet UILabel *yyhj;

@end



@implementation IndentBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
