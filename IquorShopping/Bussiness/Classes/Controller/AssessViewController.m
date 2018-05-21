//
//  AssessViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AssessViewController.h"
#import "AssessCell.h"
@interface AssessViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *assessTable;
@end

@implementation AssessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.assessTable];
}

#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
- (UITableView *)assessTable {
    if (!_assessTable) {
        _assessTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_assessTable registerNib:[UINib nibWithNibName:@"AssessCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AssessCell class])];
        _assessTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _assessTable.dataSource = self;
        _assessTable.delegate = self;
        _assessTable.tableFooterView = [UIView new];
        
    }
    return _assessTable;
}


@end
