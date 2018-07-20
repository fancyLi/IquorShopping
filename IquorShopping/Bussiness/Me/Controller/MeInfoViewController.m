//
//  MeInfoViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//
#import "MeInfoViewController.h"
#import "NikeNameViewController.h"
#import "ImageViewController.h"
#import "MeInfoTableViewCell.h"
#import "MeHeaderCell.h"
@interface MeInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *infoTableview;
@property (nonatomic, strong) UIImageView *userHeader;
@property (nonatomic, strong) NSArray *leftTitles;
@property (nonatomic, strong) NSArray *rightTitles;
@property (nonatomic, strong) IQourUser *user;

@end

@implementation MeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [IQourUser shareInstance];
    [self configInfoUI];
}

- (void)configInfoUI {
    self.title = @"个人资料";
    [self.infoTableview registerNib:[UINib nibWithNibName:@"MeHeaderCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MeHeaderCell class])];
    [self.infoTableview registerNib:[UINib nibWithNibName:@"MeInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MeInfoTableViewCell class])];
    self.infoTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoTableview.estimatedSectionHeaderHeight = 5;
    self.infoTableview.estimatedSectionFooterHeight = 0;
    self.infoTableview.dataSource = self;
    self.infoTableview.delegate = self;
    self.infoTableview.tableFooterView = [UIView new];
    
}
- (void)uploadUserAvator:(UIImage *)image {
  
//    NSDictionary *param = @{@"type":@"avatar"};

    [AFNetworkTool requestWithUrl:update_userAvatar_url params:nil picImageArray:@[image] fileName:@"avatar" success:^(id responseObject) {
        
        NSInteger status = [responseObject[@"status"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (status == 200) {
            self.userHeader.image =image;
        }
    } fail:^{
        [Dialog showErrorWithStatus:@"上传失败"];
    }];

}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return self.leftTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftTitles[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 48;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        MeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeHeaderCell class])];
        cell.textLabel.text = self.leftTitles[indexPath.section][indexPath.row];
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString:[UIUtils isNullOrEmpty:self.user.avatar]?@"":self.user.avatar]];
        @weakify(self);
        @weakify(cell);
        cell.changeAvatorBlock = ^{
            @strongify(self);
            @strongify(cell);
            [[ImageViewController shareImageVC] choosePhotoOrCamera];
            [ImageViewController shareImageVC].imageChooseBlock = ^(UIImage *image) {
                self.userHeader = cell.avatar;
                [self uploadUserAvator:image];
            };
        };
        return cell;
    }else {
        MeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeInfoTableViewCell class])];
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.rightTltle.textColor = [UIColor c_333Color];
        }else if (indexPath.section == 2 && indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.leftTitle.text = self.leftTitles[indexPath.section][indexPath.row];
        cell.rightTltle.text = self.rightTitles[indexPath.section][indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        NikeNameViewController *nikeVC = [[NikeNameViewController alloc]init];
        nikeVC.nike = self.user.nick_name;
        [self.navigationController pushViewController:nikeVC animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        NikeNameViewController *nikeVC = [[NikeNameViewController alloc]init];
        nikeVC.isCode = YES;
        [self.navigationController pushViewController:nikeVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & get
- (NSArray *)leftTitles {
    if (!_leftTitles) {
        if (self.user.is_code.intValue == 1) {
            _leftTitles = @[
                            @[@"头像", @"昵称", @"姓名", @"电话号码"],
                            @[@"我的邀请码"],
                            @[@"邀请码（选填）"]
                            ];
        }else {
            _leftTitles = @[
                            @[@"头像", @"昵称", @"姓名", @"电话号码"],
                            @[@"我的邀请码"]
                            ];
        }
        
    }
    return _leftTitles;
}

- (NSArray *)rightTitles {
    if (!_rightTitles) {
        if (self.user.is_code.intValue == 1) {
            _rightTitles = @[
                             @[@"", self.user.nick_name, self.user.user_name, self.user.user_tel],
                             @[self.user.user_code],
                             @[@""]
                             ];
        }else {
            _rightTitles = @[
                             @[@"", self.user.nick_name, self.user.user_name, self.user.user_tel],
                             @[self.user.user_code]
                             ];
        }
        
    }
    return _rightTitles;
}

@end
