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
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
@property (weak, nonatomic) IBOutlet UILabel *vipDes;

@end
@implementation MeHeaderTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
}
- (IBAction)loginClick:(id)sender {
}
- (IBAction)joinClick:(id)sender {
}
- (IBAction)infoClick:(id)sender {
    [MeHeaderTableView.getCurrentVC.navigationController pushViewController:[MeInfoViewController new] animated:YES];
}


@end
