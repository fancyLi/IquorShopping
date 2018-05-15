//
//  TeamViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "TeamViewController.h"
#import "TeamViewController.h"
#import "TeamCell.h"
@interface TeamViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *teamTable;
@end

@implementation TeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.teamTable];
    [self.teamTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TeamCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}


- (UITableView *)teamTable {
    if (!_teamTable) {
        _teamTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_teamTable registerNib:[UINib nibWithNibName:@"TeamCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([TeamCell class])];
        _teamTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _teamTable.rowHeight = 80;
        _teamTable.delegate = self;
        _teamTable.dataSource = self;
    }
    return _teamTable;
}

@end
