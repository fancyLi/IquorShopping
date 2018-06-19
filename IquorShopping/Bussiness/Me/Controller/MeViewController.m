//
//  MeViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "MeInfoViewController.h"
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
    
    if (@available(iOS 11.0, *)) {
        self.meTableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }


    [self.view addSubview:self.meTableview];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
        _meTableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
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
        WeakObj(self);
        _configView.clickButtonBlock = ^(OperateType operate) {
            if (operate == KLogin) {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [selfWeak.navigationController pushViewController:loginVC animated:YES];
            }else if (operate == KJoin) {
                
            }else if (operate == KMeInfo) {
                MeInfoViewController *infoVC = [[MeInfoViewController alloc]init];
                [selfWeak.navigationController pushViewController:infoVC animated:YES];
            }
        };
    }
    return _configView;
}
@end
