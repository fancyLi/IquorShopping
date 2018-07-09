//
//  ShopCartViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartCell.h"
#import "UploadCartViewController.h"
#import "CartModel.h"
@interface ShopCartViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isEdit;
}
@property (weak, nonatomic) IBOutlet UITableView *catTableview;
@property (weak, nonatomic) IBOutlet UIButton *chosBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *chosNums;
@property (weak, nonatomic) IBOutlet UILabel *chosPrice;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, assign) NSInteger page;
@property (weak, nonatomic) IBOutlet UIView *footView;
@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self requestCouponList];
    [self shopCartConfigUI];
    
}
- (void)shopCartConfigUI {
    self.title = @"购物车";
    _isEdit = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(startEdit:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor c_333Color];
    
    [self.catTableview registerNib:[UINib nibWithNibName:@"ShopCartCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopCartCell class])];
    self.catTableview.rowHeight = 108;
    self.catTableview.estimatedSectionHeaderHeight = 5;
    self.catTableview.estimatedSectionFooterHeight = 0;
    self.catTableview.delegate = self;
    self.catTableview.dataSource = self;
    self.catTableview.tableFooterView = [UIView new];
    @weakify(self);
    _catTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 0;
        self.arrs = nil;
        [self requestCouponList];
    }];
    _catTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestCouponList];
    }];
    
}
- (void)requestCouponList {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:shop_shoppingCart parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.catTableview.mj_footer endRefreshing];
        [self.catTableview.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[CartModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.catTableview reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
            self.footView.hidden = !self.arrs.count;
            [self.catTableview setTableBgViewWithCount:self.arrs.count img:@"icon_none_01" msg:@"购物车里是空的"];
            
        }else {
            
        }
    } fail:^{
        
    }];
}

- (void)cartOperate {
    NSDictionary *param = @{@"cart_id":@"", @"goods_id":@"", @"goods_num":@"", @"calculation_type":@""};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:shop_changeCartGoodsNum parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.catTableview.mj_footer endRefreshing];
        [self.catTableview.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[CartModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.catTableview reloadData];
            }else {
                [Dialog popTextAnimation:@"没有下一页了"];
            }
            self.footView.hidden = !self.arrs.count;
            [self.catTableview setTableBgViewWithCount:self.arrs.count img:@"icon_none_01" msg:@"购物车里是空的"];
            
        }else {
            
        }
    } fail:^{
        
    }];
}
- (void)startEdit:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        _isEdit = YES;
    }else {
        item.title = @"编辑";
        _isEdit = NO;
    }
    [self.catTableview reloadData];
}
- (IBAction)startOperate:(UIButton *)sender {
    UploadCartViewController *uploadVC = [[UploadCartViewController alloc]init];
    [self.navigationController pushViewController:uploadVC animated:YES];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopCartCell class])];
    cell.refreshLayout = _isEdit;
    cell.cart = self.arrs[indexPath.section];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set & get
- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}
@end
