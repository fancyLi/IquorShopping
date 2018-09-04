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
#import "TeamerModel.h"
@interface TeamViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *teamTable;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;
@end

@implementation TeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.teamTable];
    [self.teamTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    self.page = 1;
    [self requestTeam];
    
}

- (void)requestTeam {
    NSDictionary *param = @{@"page":@(self.page), @"team_id":self.team_id};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_userLowerLevel parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.teamTable.mj_footer endRefreshing];
        [self.teamTable.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[TeamerModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.teamTable reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
        
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
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
    return self.arrs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TeamCell class])];
    cell.teamer = self.arrs[indexPath.row];
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
        @weakify(self);
        _teamTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            self.arrs = nil;
            [self requestTeam];
        }];
        _teamTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page++;
            [self requestTeam];
        }];
    }
    return _teamTable;
}

@end
