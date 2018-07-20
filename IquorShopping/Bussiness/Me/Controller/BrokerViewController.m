//
//  BrokerViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BrokerViewController.h"
#import "BrokerCell.h"
#import "BrokerModel.h"
@interface BrokerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *captialDes;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *opBtn;
@property (weak, nonatomic) IBOutlet UITableView *brokerTableView;
@property (nonatomic, strong) NSMutableArray *brokeArrs;
@property (nonatomic, assign) NSInteger page;

@end

@implementation BrokerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self requestCommision];
    self.page = 1;
    [self requestCommisionWater];
}
- (IBAction)startDepost:(UIButton *)sender {
    [self depostBalance];
}

- (BOOL)judegCommision {
    return [self.title isEqualToString:@"我的佣金"];
}

- (void)depostBalance {
    @weakify(self);
    NSDictionary *param = @{@"money":self.money.text};
    NSString *url = [self judegCommision]?user_commisionPutForward:user_bonusPutForward;
    [AFNetworkTool postJSONWithUrl:url parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}

- (void)requestCommision {
    @weakify(self);
    NSString *url = [self judegCommision]?person_Commision_url:person_bonus_url;
    [AFNetworkTool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            if ([self judegCommision]) {
                self.money.text = responseObject[@"content"][@"commision"];
            }else{
                 self.money.text = responseObject[@"content"][@"bonus"];
            }
        }
    } fail:^{
        
    }];
}
- (void)requestCommisionWater {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
    NSString *url = [self judegCommision]?person_CommisionWater_url:bonus_Water_url;
    [AFNetworkTool postJSONWithUrl:url parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.brokerTableView.mj_footer endRefreshing];
        [self.brokerTableView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[BrokerModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.brokeArrs addObjectsFromArray:arrs];
                [self.brokerTableView reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
            
            
        }else {
        }
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configUI {
    if ([self judegCommision]) {
        self.captialDes.text = @"当前佣金(元)";
    }else {
        self.captialDes.text = @"当前分红(元)";
    }
    [self.brokerTableView registerNib:[UINib nibWithNibName:@"BrokerCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BrokerCell class])];
    self.brokerTableView.dataSource = self;
    self.brokerTableView.delegate = self;
    self.brokerTableView.rowHeight = 70;
    self.brokerTableView.tableFooterView = [UIView new];
    self.brokerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.opBtn.layer.borderColor = [UIColor c_cc0Color].CGColor;
    self.opBtn.layer.borderWidth = 1;
    self.opBtn.layer.cornerRadius = 5;
    @weakify(self);
    self.brokerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.brokeArrs = nil;
        [self requestCommisionWater];
    }];
    self.brokerTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestCommisionWater];
    }];
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brokeArrs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrokerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BrokerCell class])];
    if ([self judegCommision]) {
        [cell configBrokerCell:self.brokeArrs[indexPath.row]];
    }else {
        [cell configBonusCell:self.brokeArrs[indexPath.row]];
    }
    
    return cell;
}

- (NSMutableArray *)brokeArrs {
    if (!_brokeArrs) {
        _brokeArrs = [NSMutableArray array];
    }
    return _brokeArrs;
}
@end
