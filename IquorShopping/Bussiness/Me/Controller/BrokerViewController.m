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
    [self requestCommisionWater];
}

- (void)requestCommision {
    WeakObj(self);
    NSString *url = self.capital == KCommision?person_Commision_url:person_bonus_url;
    [AFNetworkTool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            if (self.capital == KCommision) {
                selfWeak.money.text = responseObject[@"content"][@"commision"];
            }{
                 selfWeak.money.text = responseObject[@"content"][@"bonus"];
            }
        }else {
        }
    } fail:^{
        
    }];
}
- (void)requestCommisionWater {
    NSDictionary *param = @{@"page":@"1"};
    WeakObj(self);
    NSString *url = self.capital == KCommision?person_CommisionWater_url:bonus_Water_url;
    [AFNetworkTool postJSONWithUrl:url parameters:param success:^(id responseObject) {
        [selfWeak.brokerTableView.mj_footer endRefreshing];
        [selfWeak.brokerTableView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[BrokerModel class] json:responseObject[@"message"][@"list"]];
            [selfWeak.brokeArrs addObjectsFromArray:arrs];
            [selfWeak.brokerTableView reloadData];
            
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
    if (self.capital == KCommision) {
        self.title = @"我的佣金";
        self.captialDes.text = @"当前佣金(元)";
    }else {
        self.title = @"我的分红";
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
    WeakObj(self);
    self.brokerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        selfWeak.page = 0;
        self.brokeArrs = [NSMutableArray array];
        [selfWeak requestCommisionWater];
    }];
    self.brokerTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [selfWeak requestCommisionWater];
    }];
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brokeArrs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrokerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BrokerCell class])];
    [cell configBrokerCell:self.brokeArrs[indexPath.row]];
    return cell;
}
@end
