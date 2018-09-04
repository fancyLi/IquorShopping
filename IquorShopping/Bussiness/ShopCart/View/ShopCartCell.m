//
//  ShopCartCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopCartCell.h"
#import "UIButton+IquorArea.h"
@interface ShopCartCell ()<UITextFieldDelegate>
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
@property (weak, nonatomic) IBOutlet UITextField *textf;

@end
@implementation ShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textf.delegate = self;
    self.textf.keyboardType = UIKeyboardTypeNumberPad;

    [self.reduceBtn setEnlargeEdgeWithTop:10 left:10 bottom:10 right:90];
    [self.addBtn setEnlargeEdgeWithTop:10 left:0 bottom:10 right:10];
    [self.leftButton setEnlargeEdgeWithTop:20 left:5 bottom:20 right:5];
    self.leftButton.selected = NO;
}

- (void)setCart:(CartModel *)cart {
    _cart = cart;
    [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:_cart.goods_image] placeholderImage:nil];
    self.shopName.text = _cart.goods_name;
    self.shopStan.text = [NSString stringWithFormat:@"规格：%@", _cart.attribute_value];
    self.shopPrice.text = [NSString stringWithFormat:@"￥%@", _cart.goods_price];
    self.textf.text = _cart.goods_num;
    if (self.textf.text.intValue > 1) {
        self.reduceBtn.enabled = YES;
    }
}
- (IBAction)choseButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.choseCollectBlock) {
        self.choseCollectBlock(sender.selected);
    }
}

- (IBAction)chosNum:(id)sender {
    int num = self.textf.text.intValue;
    num--;
//    self.textf.text = [NSString stringWithFormat:@"%i", num];
    if (num <= 1) {
        self.reduceBtn.enabled = NO;
        [self.reduceBtn setBackgroundColor:[UIColor c_fbfbfbColor]];
    }
    if (self.operatorCartNumBlock) {
        self.operatorCartNumBlock(@"2", @"");
    }
}
- (IBAction)chos2Num:(id)sender {
    int num = self.textf.text.intValue;
    num++;
    if (num>1) {
        self.reduceBtn.enabled = YES;
        [self.reduceBtn setBackgroundColor:[UIColor c_f5f5f5Color]];
    }

//    self.textf.text = [NSString stringWithFormat:@"%i", num];
    if (self.operatorCartNumBlock) {
        self.operatorCartNumBlock(@"1", @"");
    }
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.operatorCartNumBlock) {
        self.operatorCartNumBlock(@"3", textField.text);
    }
    return YES;
}

@end
