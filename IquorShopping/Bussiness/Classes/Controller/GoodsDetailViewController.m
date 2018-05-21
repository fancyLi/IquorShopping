//
//  GoodsDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "DetailTableHeader.h"
#import "MeSectionTableView.h"
#import "AssessCell.h"
@interface GoodsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DetailTableHeader *tableHead;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MeSectionTableView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeSectionTableView" owner:self options:nil] firstObject];
    headerView.leftTitle = @"用户评价（999+）";
    headerView.rightTitle = @"查看所有评价";
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssessCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AssessCell class])];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & get
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"AssessCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AssessCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 50;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.tableHead;
        
    }
    return _tableView;
}
- (DetailTableHeader *)tableHead {
    if (!_tableHead) {
        _tableHead = [[NSBundle mainBundle] loadNibNamed:@"DetailTableHeader" owner:self options:nil].firstObject;
    }
    return _tableHead;
}

@end
