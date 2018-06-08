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
#import "MeHeaderCell.h"
@interface MeInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *infoTableview;
@property (nonatomic, strong) NSArray *leftTitles;

@end

@implementation MeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configInfoUI];
}

- (void)configInfoUI {
    self.title = @"个人资料";
    [self.infoTableview registerNib:[UINib nibWithNibName:@"MeHeaderCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MeHeaderCell class])];
    [self.infoTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.infoTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoTableview.estimatedSectionHeaderHeight = 5;
    self.infoTableview.estimatedSectionFooterHeight = 0;
    self.infoTableview.dataSource = self;
    self.infoTableview.delegate = self;
    self.infoTableview.tableFooterView = [UIView new];
    
}
- (void)uploadUserAvator:(UIImage *)image {
    
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
        WeakObj(self);
        WeakObj(cell);
        cell.changeAvatorBlock = ^{
            [[ImageViewController shareImageVC] choosePhotoOrCamera];
            [ImageViewController shareImageVC].imageChooseBlock = ^(UIImage *image) {
                [cellWeak.headerImg setImage:image forState:UIControlStateNormal];
                [selfWeak uploadUserAvator:image];
            };
        };
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.textLabel.text = self.leftTitles[indexPath.section][indexPath.row];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        NikeNameViewController *nikeVC = [[NikeNameViewController alloc]init];
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
        _leftTitles = @[
                        @[@"头像", @"昵称", @"姓名", @"电话号码"],
                        @[@"我的邀请码"]
                        ];
    }
    return _leftTitles;
}


@end
