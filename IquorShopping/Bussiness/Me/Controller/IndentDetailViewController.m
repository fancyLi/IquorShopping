//
//  IndentDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IndentDetailViewController.h"
#import "IndentSectionView.h"
#import "IndentDetailCell.h"
#import "IndentBottomCell.h"
#import "OrderModel.h"
#import "PayKindViewController.h"
#import "AdressListViewController.h"
#import "OrderDisViewController.h"
#import "OrderResult.h"
#import "MeInfoTableViewCell.h"
@interface IndentDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameConnect;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (weak, nonatomic) IBOutlet UILabel *yzf;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *addAdree;
@property (nonatomic, strong) OrderModel *order;
@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;
@property (nonatomic, copy) NSString *addr_id;
@property (nonatomic, copy) NSString *ucid;
@property (nonatomic, copy) NSString *payType;
@property (weak, nonatomic) IBOutlet UIView *addressCon;

@property (nonatomic, strong) OrderResult *endOrder;
@property (nonatomic, copy) NSString *order_amount;
@property (nonatomic, copy) NSString *discount_money;
@property (nonatomic, copy) NSString *order_total;
@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, copy) NSString *code; //微信支付宝支付成功返回的code_sn
@end

@implementation IndentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self configUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestOrder];
}
- (IBAction)addNewAdress:(UIButton *)sender {
    [self intoAddressList];
}

- (void)configOrder {
    self.detailTable.hidden = NO;
    self.bottomView.hidden = NO;
    if (self.order.addr.aid) {
        self.addAdree.hidden = YES;
        self.nameConnect.hidden = NO;
        self.address.hidden = NO;
        self.leftIcon.hidden = NO;
        
        self.nameConnect.text = [NSString stringWithFormat:@"%@   %@", self.order.addr.contact_name, self.order.addr.contact_tel];
        self.address.text = [NSString stringWithFormat:@"%@%@%@%@", self.order.addr.province_name, self.order.addr.city_name, self.order.addr.district_name, self.order.addr.contact_addr];
    }else {
        self.addAdree.hidden = NO;
        self.nameConnect.hidden = YES;
        self.address.hidden = YES;
        self.leftIcon.hidden = YES;
    }
    //订单总额
    CGFloat num = 0.00;
    int all_num = 0;
    for (OrderGoods *order in self.order.goods_list) {
        int goods_num = order.goods_num.intValue;
        all_num += goods_num;
        CGFloat goods_price = order.goods_price.floatValue;
        num += goods_num*goods_price;
        
    }
    self.goods_num = [NSString stringWithFormat:@"%i", all_num];
    self.order_amount = [NSString stringWithFormat:@"%.2f", num];
    
    IndentBottomCell *cell = [self.detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    cell.goodsPrice.text = [NSString stringWithFormat:@"￥%.2f",num];
//    CGFloat endPrice = 0 ;
//    CGFloat disPrice = 0;
    
//    if (![UIUtils isNullOrEmpty:self.order.discount]) {
//         endPrice = num*(self.order.discount.floatValue/10);
//         disPrice = num*(1-self.order.discount.floatValue/10);
//    }
    
    //折扣
//    self.discount_money = [NSString stringWithFormat:@"%.2f", endPrice];
//    cell.vipPrice.text = [NSString stringWithFormat:@"-￥%.2f", disPrice];
    self.discount_money = self.order.discount_total;
    cell.vipPrice.text = [NSString stringWithFormat:@"-￥%.2f", self.order.discount_total.floatValue];
    CGFloat cou = 0.00;
    if (self.order.coupon.count) {
        Coupon *coupon = self.order.coupon.firstObject;
        self.ucid = coupon.ucid;
        cou = coupon.money.floatValue;
        cell.dicountPrice.text = [NSString stringWithFormat:@"-￥%@", coupon.money];
    }else {
        self.ucid = @"";
    }

    CGFloat order_total = num-cou - self.order.discount_total.floatValue;
    self.order_total = [NSString stringWithFormat:@"%.2f", order_total];
    self.yzf.text = [NSString stringWithFormat:@"应支付：￥%.2f", order_total];
}

- (void)configUI {
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.borderColor = [UIColor c_333Color].CGColor;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.clipsToBounds = YES;
    self.rightBtn.layer.cornerRadius = 5;
    self.detailTable.dataSource = self;
    self.detailTable.delegate = self;
    self.detailTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.detailTable registerNib:[UINib nibWithNibName:@"IndentDetailCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentDetailCell class])];
    [self.detailTable registerNib:[UINib nibWithNibName:@"IndentBottomCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([IndentBottomCell class])];
    [self.detailTable registerNib:[UINib nibWithNibName:@"MeInfoTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([MeInfoTableViewCell class])];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(intoAddressList)];
    [self.addressCon addGestureRecognizer:tapGes];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)intoAddressList {
    AdressListViewController *vc = [[AdressListViewController alloc]init];
    @weakify(self);
    vc.opretorAddressBlock = ^(AddressModel *model) {
        @strongify(self);
        self.addr_id = model.aid;
        [self requestOrder];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)requestOrder {
    @weakify(self);
    NSDictionary *param = @{@"goods_ids_nums":self.goods_ids_nums, @"addr_id":[UIUtils isNullOrEmpty:self.addr_id]?@"":self.addr_id, @"ucid":[UIUtils isNullOrEmpty:self.ucid]?@"":self.ucid};
    [AFNetworkTool postJSONWithUrl:order_beforeSubOrder parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.order = [OrderModel yy_modelWithDictionary:responseObject[@"content"]];
            [self configOrder];
            [self.detailTable reloadData];
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
    }];
}
- (IBAction)submitOrder:(UIButton *)sender {
    IndentBottomCell *cell = [self.detailTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
//    @weakify(self);
    if ([UIUtils isNullOrEmpty:self.payType]) {
        [Dialog popTextAnimation:@"请选择支付方式"];
    }else if ([UIUtils isNullOrEmpty:self.order.addr.aid]) {
        [Dialog popTextAnimation:@"请添加收货地址"];
    }
    else {
      
        NSDictionary *param = @{@"pay_type":self.payType,
                                @"pay_scene":self.pay_scene,
                                @"order_type":self.order_type,
                                @"addr_id":self.order.addr.aid,
                                @"goods_ids_nums":self.goods_ids_nums,
                                @"goods_num":self.goods_num,
                                @"ucid":self.ucid,
                                @"discount_money":self.discount_money,
                                @"order_total":self.order_total,
                                @"message":cell.textview.text};
       
        [[IquorDataManager shareInstance] submitOrderParameters:param payKind:self.payType enterVC:YES orderCom:^(BOOL isScu) {
            
        }];
    }
    
}

#pragma mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.order.goods_list.count;
    }else if (section == 1) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }else if (indexPath.section == 1) {
        return 45;
    }
    return 270;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        IndentSectionView *sectionView = [[NSBundle mainBundle] loadNibNamed:@"IndentSectionView" owner:self options:nil].firstObject;
//        return sectionView;
//    }else {
        return [UIView new];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IndentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentDetailCell class])];
        cell.order = self.order.goods_list[indexPath.row];
        return cell;
    }else if (indexPath.section == 1) {
        MeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeInfoTableViewCell class])];
        cell.shareBtn.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.leftTitle.text = @"支付方式";
        }else {
            cell.leftTitle.text = @"优惠券";
        }
        return cell;
    }else {
        IndentBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentBottomCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MeInfoTableViewCell *cell = (MeInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section ==1 && indexPath.row == 0) {
        //支付方式
        PayKindViewController *vc = [[PayKindViewController alloc]init];
        vc.pay_scene = @"2";
        vc.curPay = self.payType;
        @weakify(self);
        vc.operatorPayCellBlock = ^(OrderPay *orderPay) {
            @strongify(self);
            self.payType = orderPay.pay_type;
            cell.rightTltle.text = orderPay.type_name;
        };
       
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        OrderDisViewController *vc = [[OrderDisViewController alloc]init];
        vc.order_amount = self.order_amount;
        vc.operatorOrderBlock = ^(DiscountModel *discount) {
            self.ucid = discount.ucid;
            cell.rightTltle.text = [NSString stringWithFormat:@"-￥%@", discount.money];
            [self requestOrder];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
