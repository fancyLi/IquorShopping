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
@property (nonatomic, strong) NSMutableArray *cartIds;
@property (nonatomic, strong) NSMutableIndexSet *indexSets;
@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self shopCartConfigUI];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    self.arrs = nil;
    [self requestCouponList];
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
        self.page = 1;
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

- (void)deleteCart {
    if (self.cartIds.count) {
        NSString *str = [self.cartIds componentsJoinedByString:@","];
        NSDictionary *param = @{@"cart_ids":str};
            @weakify(self);
        [AFNetworkTool postJSONWithUrl:shop_delCartGoods parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                [self.arrs removeObjectsAtIndexes:self.indexSets];
                [self.catTableview deleteSections:self.indexSets withRowAnimation:UITableViewRowAnimationMiddle];
            }else {
                
            }
        } fail:^{
            
        }];
    }else {
        [Dialog popTextAnimation:@"没有选择要删除的商品"];
    }
    
}

- (void)cartOperate:(NSString *)op nums:(NSString *)num cat:(CartModel *)cat {
   
    NSDictionary *param = @{@"cart_id":cat.cart_id, @"goods_id":cat.goods_id, @"goods_num":num, @"calculation_type":op};
    [AFNetworkTool postJSONWithUrl:shop_changeCartGoodsNum parameters:param success:^(id responseObject) {

        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            
        }else {
            
        }
    } fail:^{
        
    }];
}

- (void)startOrder {
    UploadCartViewController *uploadVC = [[UploadCartViewController alloc]init];
    [self.navigationController pushViewController:uploadVC animated:YES];
}
- (void)startEdit:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        self.chosPrice.hidden = YES;
        [self.sureBtn setTitle:@"删除所选" forState:UIControlStateNormal];
        _isEdit = YES;
    }else {
        item.title = @"编辑";
        self.chosPrice.hidden = NO;
        [self.sureBtn setTitle:@"下单" forState:UIControlStateNormal];
        _isEdit = NO;
    }
//    [self.catTableview reloadData];
}
- (IBAction)startOperate:(UIButton *)sender {
    if (_isEdit) {
        [self deleteCart];
    }else {
        [self startOrder];
    }
    
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
//    cell.refreshLayout = _isEdit;
    CartModel *cart = self.arrs[indexPath.section];
    @weakify(self);
    cell.operatorCartNumBlock = ^(NSString *op, NSString *num) {
        @strongify(self);
        [self cartOperate:op nums:num cat:self.arrs[indexPath.section]];
    };
    cell.choseCollectBlock = ^(BOOL sel) {
        @strongify(self);
        if (sel) {
            [self.cartIds addObject:cart.cart_id];
            [self.indexSets addIndexes:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }else {
            if ([self.cartIds containsObject:cart.cart_id]) {
                [self.cartIds removeObject:cart.cart_id];
            }
            [self.indexSets removeIndexes:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }
        self.chosNums.text = [NSString stringWithFormat:@"已选(%lu)", (unsigned long)self.cartIds.count];
        
        if (self.cartIds.count) {
            [self.chosBtn setImage:[UIImage imageNamed:@"icon_normal_02"] forState:UIControlStateNormal];
        }else {
            [self.chosBtn setImage:[UIImage imageNamed:@"icon_normal_01"] forState:UIControlStateNormal];
        }
    };
    cell.cart = cart;
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

- (NSMutableArray *)cartIds {
    if (!_cartIds) {
        _cartIds = [NSMutableArray array];
    }
    return _cartIds;
}

- (NSMutableIndexSet *)indexSets {
    if (!_indexSets) {
        _indexSets = [NSMutableIndexSet indexSet];
    }
    return _indexSets;
}
@end
