//
//  MeHeaderTableView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeHeaderTableView.h"
#import "MeInfoViewController.h"
@interface MeHeaderTableView ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *startLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *nikeName;
@property (weak, nonatomic) IBOutlet UILabel *vipDes;
@property (weak, nonatomic) IBOutlet UILabel *agentDes;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;


@end
@implementation MeHeaderTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
}
- (IBAction)loginClick:(id)sender {
    if (self.clickButtonBlock) {
        self.clickButtonBlock(KLogin);
    }
//    UIButton *btn = (UIButton *)sender;
//    btn.selected = !btn.selected;
//    self.heightLayout.constant = btn.selected ? 0 : 60;
}
- (IBAction)joinClick:(id)sender {
    if (self.clickButtonBlock) {
        self.clickButtonBlock(KJoin);
    }
}
- (IBAction)infoClick:(id)sender {
    if (self.clickButtonBlock) {
        self.clickButtonBlock(KMeInfo);
    }
}


@end
