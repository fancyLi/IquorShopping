//
//  MeHeaderTableView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeHeaderTableView.h"
#import "MeInfoViewController.h"
#import "UIControl+IquorArea.h"
@interface MeHeaderTableView ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *startLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *nikeName;
@property (weak, nonatomic) IBOutlet UILabel *vipDes;
@property (weak, nonatomic) IBOutlet UILabel *agentDes;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightLayout;
@property (weak, nonatomic) IBOutlet UIButton *meInfoBtn;


@end
@implementation MeHeaderTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
    [self.meInfoBtn setEnlargeEdge:20];
    
}

- (void)setIsfresh:(BOOL)isfresh {
    _isfresh = isfresh;
    IquorUser *user = [IquorUser shareIquorUser];
    if (user.user_tel) {
        self.startLoginBtn.hidden = YES;
        self.nikeName.text = user.nick_name;
        [self.userHeader sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"icon_head_01"]];
        
    }else {
        self.nikeName.hidden = YES;
        self.startLoginBtn.hidden = NO;
    }
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
    if (self.clickButtonBlock && [IquorUser shareIquorUser].user_tel) {
        self.clickButtonBlock(KJoin);
    }else {
        self.clickButtonBlock(KLogin);
    }
}
- (IBAction)infoClick:(id)sender {
    if (self.clickButtonBlock  && [IquorUser shareIquorUser].user_tel) {
        self.clickButtonBlock(KMeInfo);
    }else {
        self.clickButtonBlock(KLogin);
    }
}


@end
