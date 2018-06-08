//
//  AdressListViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AdressListViewController.h"
#import "AddressViewController.h"
#import "AddressModel.h"
#import "AddressCell.h"
@interface AdressListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *adressTableview;
@property (nonatomic, strong) NSArray *addressArrs;
@end

@implementation AdressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configAddressUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestAddressData];
}
- (void)configAddressUI {
    self.title = @"收货地址";
    self.adressTableview.dataSource = self;
    self.adressTableview.delegate = self;
    self.adressTableview.rowHeight = 120;
    self.adressTableview.tableFooterView = [UIView new];
    self.adressTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.adressTableview registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AddressCell class])];
}

- (void)requestAddressData {
 
    WeakObj(self);
    [AFNetworkTool postJSONWithUrl:user_addrList_url parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            selfWeak.addressArrs = [NSArray yy_modelArrayWithClass:[AddressModel class] json:responseObject[@"content"]];
            [selfWeak.adressTableview reloadData];
        }else {
        }
    } fail:^{
        
    }];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.addressArrs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressCell class])];
    AddressModel *model = self.addressArrs[indexPath.section];
    [cell configModel:model];
    WeakObj(self);
    cell.operateAddressBlock = ^(AddressOperate operate) {
        if (operate == KEditCurrent) {
            AddressViewController *addressVC = [[AddressViewController alloc]init];
            addressVC.aid = model.aid;
            [selfWeak.navigationController pushViewController:addressVC animated:YES];
        }
    };
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
