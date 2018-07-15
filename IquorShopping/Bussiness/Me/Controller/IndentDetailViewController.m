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
@interface IndentDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameConnect;
@property (weak, nonatomic) IBOutlet UILabel *address;
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

@end

@implementation IndentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self requestOrder];
    [self configUI];
}

- (IBAction)addNewAdress:(UIButton *)sender {
    
}

- (void)showAdress {
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
    [self.detailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
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
    NSDictionary *param = @{@"goods_ids":@"1", @"addr_id":[UIUtils isNullOrEmpty:self.addr_id]?@"":self.addr_id, @"ucid":[UIUtils isNullOrEmpty:self.ucid]?@"":self.ucid};
    [AFNetworkTool postJSONWithUrl:order_beforeSubOrder parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.order = [OrderModel yy_modelWithDictionary:responseObject[@"content"]];
            [self showAdress];
            [self.detailTable reloadData];
        }
    } fail:^{
        
    }];
}

- (void)submitOrder {
    @weakify(self);
    NSDictionary *param = @{@"pay_type":@"1", @"pay_scene":@"", @"addr_id":@"", @"goods_ids":@"",@"cart_ids":@"", @"goods_num":@"", @"ucid":@"", @"discount_money":@"", @"order_total":@""};
    [AFNetworkTool postJSONWithUrl:pay_requestPayment parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.order = [OrderModel yy_modelWithDictionary:responseObject[@"content"]];
            [self showAdress];
            [self.detailTable reloadData];
        }
    } fail:^{
        
    }];
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"支付方式";
        }else {
            cell.textLabel.text = @"优惠券";
        }
        return cell;
    }else {
        IndentBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IndentBottomCell class])];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==1 && indexPath.row == 0) {
        //支付方式
        PayKindViewController *vc = [[PayKindViewController alloc]init];
        vc.pay_scene = @"2";
        @weakify(self);
        vc.operatorPayCellBlock = ^(NSString *type) {
            @strongify(self);
            self.payType = type;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        
    }
}
@end
