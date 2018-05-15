//
//  IndentDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentDetailViewController.h"
#import "IndentSectionView.h"
#import "IndentDetailCell.h"
#import "IndentBottomCell.h"
@interface IndentDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameConnect;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (weak, nonatomic) IBOutlet UILabel *yzf;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@end

@implementation IndentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self configUI];
}

- (void)configUI {
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.borderColor = [UIColor c_333Color].CGColor;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.clipsToBounds = YES;
    self.rightBtn.layer.cornerRadius = 5;
    [self.detailTable registerNib:[UINib nibWithNibName:@"IndentDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentDetailCell class])];
    [self.detailTable registerNib:[UINib nibWithNibName:@"IndentBottomCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentBottomCell class])];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 200;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        IndentSectionView *sectionView = [[NSBundle mainBundle] loadNibNamed:@"IndentSectionView" owner:self options:nil].firstObject;
        return sectionView;
    }else {
        return [UIView new];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IndentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentDetailCell class])];
        return cell;
    }else {
        IndentBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentBottomCell class])];
        return cell;
    }
    
}
@end
