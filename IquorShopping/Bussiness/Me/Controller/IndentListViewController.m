//
//  IndentListViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentListViewController.h"
#import "IndentDetailViewController.h"
#import "IndentDetailCell.h"
#import "FooterTableView.h"
@interface IndentListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *indentTable;
@end

@implementation IndentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.indentTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.indentTable];
    [self.indentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    FooterTableView *footView = [[NSBundle mainBundle] loadNibNamed:@"FooterTableView" owner:self options:nil].firstObject;
    return footView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IndentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentDetailCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IndentDetailViewController *detailVC = [[IndentDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (UITableView *)indentTable {
    if (!_indentTable) {
        _indentTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_indentTable registerNib:[UINib nibWithNibName:@"IndentDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentDetailCell class])];
        _indentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _indentTable.rowHeight = 100;
        _indentTable.estimatedSectionHeaderHeight = 0;
        _indentTable.estimatedSectionFooterHeight = 50;
        _indentTable.delegate = self;
        _indentTable.dataSource = self;
    }
    return _indentTable;
}
@end
