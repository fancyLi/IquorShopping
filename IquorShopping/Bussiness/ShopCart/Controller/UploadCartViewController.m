//
//  UploadCartViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/21.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "UploadCartViewController.h"
#import "UITableViewCell+Layout.h"
#import "CartTextCell.h"
#import "ShopCartCell.h"
@interface UploadCartViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *contentTableview;

@end

@implementation UploadCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uploadCartConfigUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)uploadCartConfigUI {
    self.title = @"提交订单";
    [self.contentTableview registerNib:[UINib nibWithNibName:@"ShopCartCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopCartCell class])];
    [self.contentTableview registerNib:[UINib nibWithNibName:@"CartTextCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CartTextCell class])];
    self.contentTableview.rowHeight = 108;
    self.contentTableview.estimatedSectionHeaderHeight = 5;
    self.contentTableview.estimatedSectionFooterHeight = 0;
    self.contentTableview.delegate = self;
    self.contentTableview.dataSource = self;
    self.contentTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableview.tableFooterView = [UIView new];
    
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 108;
    }else {
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopCartCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.refreshLayout = YES;
        return cell;
    }else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"支付方式";
        cell.detailTextLabel.text = @"22";
        return cell;
    }else if (indexPath.section == 2) {
        CartTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CartTextCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"支付方式";
        cell.detailTextLabel.text = @"22";
        return cell;
    }
    
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
