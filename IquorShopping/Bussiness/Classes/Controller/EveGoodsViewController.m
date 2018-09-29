//
//  EveGoodsViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "EveGoodsViewController.h"
#import "IndentModel.h"
#import "EveGoodsTableCell.h"
#import "EveGoodsView.h"
@interface EveGoodsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) IndentModel *indent;
@property (nonatomic, assign) NSInteger curEve;

@end

@implementation EveGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.curEve = -1;
    [self requestOrderInfo];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 120;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.tableFooterView = [UIView new];
    [self.tableview registerNib:[UINib nibWithNibName:@"EveGoodsTableCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([EveGoodsTableCell class])];
    // Do any additional setup after loading the view from its nib.
}
- (void)requestOrderInfo {
    NSDictionary *param = @{@"order_id":self.order_id};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_orderInfo parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.indent = [IndentModel yy_modelWithDictionary:responseObject[@"content"]];
            [self.tableview reloadData];
        }
    } fail:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.curEve) {
        return 350;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.curEve == section) {
        EveGoodsView *eveGoodsView = [[NSBundle mainBundle] loadNibNamed:@"EveGoodsView" owner:self options:nil].firstObject;
        eveGoodsView.goods_id = self.indent.goods_list[section].goods_id;
        eveGoodsView.order_id = self.indent.order_info.order_id;
        return eveGoodsView;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indent.goods_list.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EveGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EveGoodsTableCell class])];
    [cell configCell:self.indent.goods_list[indexPath.section] orderInfo:self.indent.order_info];
    @weakify(self);
    cell.operatorCellBlock = ^{
        @strongify(self);
        self.curEve = indexPath.section;
        [self.tableview reloadData];
    };
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
