//
//  ShopCartCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopCartCell.h"
#import "UIControl+IquorArea.h"
@interface ShopCartCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopStan;
@property (weak, nonatomic) IBOutlet UILabel *shopPrice;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *nums;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *withLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayout;

@end
@implementation ShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.viewContainer.layer.borderColor = [UIColor c_999Color].CGColor;
//    self.viewContainer.layer.borderWidth = 1;
//    self.viewContainer.layer.cornerRadius = 3;
    [self.reduceBtn setEnlargeEdgeWithTop:10 right:0 bottom:10 left:10];
    [self.addBtn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:0];
    
}
- (IBAction)chosNum:(id)sender {
    int num = self.nums.text.intValue;
    num--;
    self.nums.text = [NSString stringWithFormat:@"%i", num];
    if (num <= 1) {
        self.reduceBtn.enabled = NO;
        [self.reduceBtn setBackgroundColor:[UIColor c_fbfbfbColor]];
    }
}
- (IBAction)chos2Num:(id)sender {
    int num = self.nums.text.intValue;
    num++;
    if (num>1) {
        self.reduceBtn.enabled = YES;
        [self.reduceBtn setBackgroundColor:[UIColor c_f5f5f5Color]];
    }
    self.nums.text = [NSString stringWithFormat:@"%i", num];
    
}

- (void)setRefreshLayout:(BOOL)refreshLayout {
    _refreshLayout = refreshLayout;
    self.withLayout.constant = _refreshLayout ? 18 : 0;
    self.leftLayout.constant = _refreshLayout ? 10 : 0;
    self.rightLayout.constant = _refreshLayout ? 5 : 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
