//
//  MeViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeViewController.h"
#import "MeConfigTableViewCell.h"
#import "MeHeaderTableView.h"
#import "MeSectionTableView.h"
#import "MeConfigModel.h"
@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource, MeConfigTableViewCellDelegate>
@property (nonatomic, strong) UITableView *meTableview;
@property (nonatomic, strong) MeHeaderTableView *configView;
@property (nonatomic, strong) MeConfigModel *configModel;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.meTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeConfigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeConfigTableViewCell class])];
    cell.delegate = self;
    cell.cellModel = _configModel.configModels[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MeSectionTableView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeSectionTableView" owner:self options:nil] firstObject];
    headerView.section = section;
    return headerView;
}
#pragma mark MeConfigTableViewCellDelegate
- (void)selectedConfigModel:(MeConfigModel *)cm {
    Class cls = NSClassFromString(cm.className);
    UIViewController *vc = [[cls alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark set & get
- (UITableView *)meTableview {
    if (!_meTableview) {
        _meTableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _meTableview.dataSource = self;
        _meTableview.delegate = self;
        _meTableview.rowHeight = 100;
        _meTableview.sectionFooterHeight = 0.1;
        _meTableview.sectionHeaderHeight = 50;
        _meTableview.backgroundColor = [UIColor c_f6f6Color];
        _meTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_meTableview registerNib:[UINib nibWithNibName:@"MeConfigTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MeConfigTableViewCell class])];
        _meTableview.tableHeaderView = self.configView;
        _configModel = [[MeConfigModel alloc]init];
        
    }
    return _meTableview;
}

- (MeHeaderTableView *)configView {
    if (!_configView) {
        _configView = [[[NSBundle mainBundle]loadNibNamed:@"MeHeaderTableView" owner:self options:nil] firstObject];
    }
    return _configView;
}
@end
