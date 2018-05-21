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
@interface ShopCartViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isEdit;
}
@property (weak, nonatomic) IBOutlet UITableView *catTableview;
@property (weak, nonatomic) IBOutlet UIButton *chosBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *chosNums;
@property (weak, nonatomic) IBOutlet UILabel *chosPrice;
@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 10;
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
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set & get

@end
