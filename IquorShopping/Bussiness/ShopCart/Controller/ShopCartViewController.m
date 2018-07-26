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
#import "IndentDetailViewController.h"
#import "GoodsInfoViewController.h"

@interface ShopCartViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isEdit;
}
@property (weak, nonatomic) IBOutlet UITableView *catTableview;
@property (weak, nonatomic) IBOutlet UIButton *chosBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *chosNums;
@property (weak, nonatomic) IBOutlet UILabel *chosPrice;
@property (nonatomic, strong) NSArray *arrs;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIView *emView;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (nonatomic, strong) UIButton *itemButton;
@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.goButton.layer.cornerRadius = 5;
    self.goButton.layer.borderColor =UIColorFromRGB(0xff7200).CGColor;
    self.goButton.layer.borderWidth = 1;
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [saveBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveBtn addTarget:self action:@selector(startEdit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
    self.itemButton = saveBtn;
    
    [self.catTableview registerNib:[UINib nibWithNibName:@"ShopCartCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopCartCell class])];
    self.catTableview.rowHeight = 108;
    self.catTableview.estimatedSectionHeaderHeight = 5;
    self.catTableview.estimatedSectionFooterHeight = 0;
    self.catTableview.delegate = self;
    self.catTableview.dataSource = self;
    self.catTableview.tableFooterView = [UIView new];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadCartList];
     _isEdit = NO;
    self.chosPrice.hidden = NO;
    [self.sureBtn setTitle:@"下单" forState:UIControlStateNormal];
    [self.itemButton setTitle:@"编辑" forState:UIControlStateNormal];
    
}
- (IBAction)bottomButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (CartModel *cart in self.arrs) {
        cart.isSec = sender.selected;
    }
    [self.catTableview reloadData];
    [self refreshFooterView];
    
}


- (void)loadCartList {
    self.arrs = nil;
    [self requestCouponList];
}
- (IBAction)goShopping:(UIButton *)sender {
    self.tabBarController.selectedIndex = 0;
}

- (void)requestCouponList {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:shop_shoppingCart parameters:nil success:^(id responseObject) {
        @strongify(self);
       

        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.arrs = [NSArray yy_modelArrayWithClass:[CartModel class] json:responseObject[@"content"][@"list"]];
            if (!self.arrs.count) {
                self.emView.hidden = NO;
                self.footView.hidden = YES;
                self.itemButton.hidden = YES;
            }else {
                self.emView.hidden = YES;
                self.footView.hidden = NO;
                self.itemButton.hidden = NO;
            }
            [self refreshFooterView];
            [self.catTableview reloadData];
           
        }else {
            self.emView.hidden = NO;
            self.footView.hidden = YES;
            self.itemButton.hidden = YES;
        }
    } fail:^{
        
    }];
}

- (void)deleteCart {
    NSMutableArray *arrStr = [NSMutableArray array];
    for (CartModel *cart in self.arrs) {
        if (cart.isSec) {
            [arrStr addObject:cart.cart_id];
        }
    }
    if (arrStr.count) {
        NSDictionary *param = @{@"cart_ids":[arrStr componentsJoinedByString:@","]};
        @weakify(self);
        [AFNetworkTool postJSONWithUrl:shop_delCartGoods parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                [self loadCartList];
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
        if (code == 200) {
            [self loadCartList];
        }else {
            
        }
    } fail:^{
        
    }];
}

- (void)startOrder {
    NSMutableArray *arrStr = [NSMutableArray array];
    for (CartModel *cart in self.arrs) {
        if (cart.isSec) {
            [arrStr addObject:[NSString stringWithFormat:@"%@#%@", cart.goods_id, cart.goods_num]];
        }
    }
    if (arrStr.count) {
        IndentDetailViewController *vc = [[IndentDetailViewController alloc]init];
        vc.goods_ids_nums = [arrStr componentsJoinedByString:@","];
        vc.pay_scene = @"4";
        vc.order_type = @"2";
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [Dialog popTextAnimation:@"您还没有选择商品"];
    }
    
}
- (void)startEdit:(UIButton *)item {
    if ([item.titleLabel.text isEqualToString:@"编辑"]) {
        [item setTitle:@"完成" forState:UIControlStateNormal];
        self.chosPrice.hidden = YES;
        [self.sureBtn setTitle:@"删除所选" forState:UIControlStateNormal];
        _isEdit = YES;
    }else {
        [item setTitle:@"编辑" forState:UIControlStateNormal];
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
- (void)refreshFooterView {
    CGFloat price = 0.0;
    int count = 0;
    for (CartModel *cart in self.arrs) {
        if (cart.isSec) {
            count++;
            price = price + cart.goods_num.intValue*cart.goods_price.floatValue;
        }
    }
    self.chosPrice.text = [NSString stringWithFormat:@"￥%.2f", price];
    self.chosNums.text = [NSString stringWithFormat:@"已选(%lu)", (unsigned long)count];
    if (count > 0) {
        self.bottomButton.selected = YES;
        [self.chosBtn setImage:[UIImage imageNamed:@"icon_normal_02"] forState:UIControlStateNormal];
    }else {
        self.bottomButton.selected = NO;
        [self.chosBtn setImage:[UIImage imageNamed:@"icon_normal_01"] forState:UIControlStateNormal];
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
    cell.cart = cart;
    cell.leftButton.selected = cart.isSec;
    @weakify(self);
    cell.operatorCartNumBlock = ^(NSString *op, NSString *num) {
        @strongify(self);
        [self cartOperate:op nums:num cat:self.arrs[indexPath.section]];
    };
    cell.choseCollectBlock = ^(BOOL sel) {
        @strongify(self);
        cart.isSec = sel;
        [self refreshFooterView];
    };
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsInfoViewController *vc = [[GoodsInfoViewController alloc]init];
    CartModel *cart = self.arrs[indexPath.section];
    vc.goods_id = cart.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
