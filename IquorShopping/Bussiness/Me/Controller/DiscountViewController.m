//
//  DiscountViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DiscountViewController.h"
#import "DiscountCell.h"
@interface DiscountViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *disTable;
@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    [self.view addSubview:self.disTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DiscountCell class])];
    return cell;
}

- (UITableView *)disTable {
    if (!_disTable) {
        _disTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_disTable registerNib:[UINib nibWithNibName:@"DiscountCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([DiscountCell class])];
        _disTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _disTable.delegate = self;
        _disTable.dataSource = self;
        _disTable.rowHeight = 70;
        _disTable.estimatedSectionHeaderHeight = 0;
        _disTable.estimatedSectionFooterHeight = 0;
    }
    return _disTable;
}

@end
