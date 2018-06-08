//
//  AddressCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/5.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AddressCell.h"
#import "AddressModel.h"
@interface AddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;

@end

@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.deleteBtn.layer.cornerRadius = 5;
    self.deleteBtn.layer.borderColor = [UIColor c_999Color].CGColor;
    self.deleteBtn.layer.borderWidth = 1;
    self.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = 5;
    // Initialization code
}

- (void)configModel:(AddressModel *)model {
    self.name.text = model.contact_name;
    self.tel.text = model.contact_tel;
    self.adress.text = [NSString stringWithFormat:@"%@%@%@%@", model.province_name, model.city_name, model.district_name, model.contact_addr];
    if ([model.defaultStatus isEqualToString:@"2"]) {
        self.leftLayout.constant = 5;
    }else {
        self.leftLayout.constant = -30;
    }
}
- (IBAction)editClick:(id)sender {
    if (self.operateAddressBlock) {
        self.operateAddressBlock(KEditCurrent);
    }
}
- (IBAction)deleteClick:(id)sender {
    if (self.operateAddressBlock) {
        self.operateAddressBlock(KDeleteCurrent);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
