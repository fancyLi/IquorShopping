//
//  MeCollectViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeCollectViewController.h"
#import "CollectedCell.h"
@interface MeCollectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *chosIcon;
@property (weak, nonatomic) IBOutlet UILabel *chosNums;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UITableView *collectedTable;

@end

@implementation MeCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(startEdit)];
    self.collectedTable.delegate = self;
    self.collectedTable.dataSource = self;
    [self.collectedTable registerNib:[UINib nibWithNibName:@"CollectedCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CollectedCell class])];
    self.collectedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectedTable.delegate = self;
    self.collectedTable.dataSource = self;
    self.collectedTable.rowHeight = 100;
    self.collectedTable.estimatedSectionHeaderHeight = 0;
    self.collectedTable.estimatedSectionFooterHeight = 0;
}

- (void)startEdit {
    
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
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CollectedCell class])];
    return cell;
}


@end
