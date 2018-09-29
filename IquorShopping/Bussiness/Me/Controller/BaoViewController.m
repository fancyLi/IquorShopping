//
//  BaoViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/12.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "BaoViewController.h"
#import "StartBaoViewController.h"
#import "BrokerCell.h"
#import "BrokerModel.h"
#import "RechargeViewController.h"
@interface BaoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@property (weak, nonatomic) IBOutlet UIButton *outButton;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *brokeArrs;
@property (nonatomic, assign) NSInteger page;
@end

@implementation BaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestUserBalance];
    
// Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    self.brokeArrs = nil;
    [self requestBalanceWater];
}
- (IBAction)startRecharge:(UIButton *)sender {
    RechargeViewController *vc = [[RechargeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)startOut:(UIButton *)sender {
    StartBaoViewController *vc = [[StartBaoViewController alloc]init];
    vc.money = self.money.text;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)configUI {
    
    [self.tableview registerNib:[UINib nibWithNibName:@"BrokerCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([BrokerCell class])];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 70;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.outButton.layer.borderColor = [UIColor c_cc0Color].CGColor;
    self.outButton.layer.borderWidth = 1;
    self.outButton.layer.cornerRadius = 5;
    self.rechargeButton.layer.cornerRadius = 5;
    @weakify(self);
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.brokeArrs = nil;
        [self requestBalanceWater];
    }];
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestBalanceWater];
    }];
}

- (void)requestUserBalance {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_userBalance parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.money.text = responseObject[@"content"][@"user_money"][@"balance"];
        }
    } fail:^{
        
    }];
}
- (void)requestBalanceWater {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
  
    [AFNetworkTool postJSONWithUrl:user_balanceWater parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.tableview.mj_footer endRefreshing];
        [self.tableview.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[BrokerModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.brokeArrs addObjectsFromArray:arrs];
                [self.tableview reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}
#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.brokeArrs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrokerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BrokerCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confiBlanceCell:self.brokeArrs[indexPath.row]];
    return cell;
}

- (NSMutableArray *)brokeArrs {
    if (!_brokeArrs) {
        _brokeArrs = [NSMutableArray array];
    }
    return _brokeArrs;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
