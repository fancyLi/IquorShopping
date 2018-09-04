//
//  CollectedCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "CollectedCell.h"
#import "UIButton+IquorArea.h"
@interface CollectedCell ()
@property (weak, nonatomic) IBOutlet UIButton *chosBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chosBtnLeadLayoutConstraint;
@end

@implementation CollectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.chosBtnLeadLayoutConstraint.constant = -18;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.chosBtn setEnlargeEdge:15];
}
- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (_isEdit) {
        self.chosBtnLeadLayoutConstraint.constant = 5;
    }else {
        self.chosBtnLeadLayoutConstraint.constant = -18;
    }
}
- (void)setCollect:(CollectModel *)collect {
    _collect = collect;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:collect.goods_image] placeholderImage:nil];
    self.name.text = _collect.goods_name;
    self.des.text = [NSString stringWithFormat:@"规格：%@", _collect.attribute_value];
    self.price.text = [NSString stringWithFormat:@"￥%@", _collect.goods_price];
    self.chosBtn.selected = _collect.isScu;
}
- (IBAction)choseOperate:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.choseCollectBlock) {
        self.choseCollectBlock(sender.selected);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
