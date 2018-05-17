//
//  BrokerViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BrokerViewController.h"
#import "BrokerCell.h"
@interface BrokerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *opBtn;
@property (weak, nonatomic) IBOutlet UITableView *brokerTableView;

@end

@implementation BrokerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的佣金";
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configUI {
    
    [self.brokerTableView registerNib:[UINib nibWithNibName:@"BrokerCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BrokerCell class])];
    self.brokerTableView.dataSource = self;
    self.brokerTableView.delegate = self;
    self.brokerTableView.rowHeight = 70;
    self.brokerTableView.tableFooterView = [UIView new];
    self.brokerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.opBtn.layer.borderColor = [UIColor c_cc0Color].CGColor;
    self.opBtn.layer.borderWidth = 1;
    self.opBtn.layer.cornerRadius = 5;
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrokerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BrokerCell class])];
    return cell;
}
@end
