//
//  GoodsDetailViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "AddGoodsViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DetailTableHeader.h"
#import "DetailTableFooter.h"
#import "DetailPageFooter.h"
#import "MeSectionTableView.h"
#import "GoodsInfoModel.h"
#import "AssessCell.h"
@interface GoodsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DetailTableHeader *tableHead;
@property (nonatomic, strong) DetailTableFooter *tableFooter;
@property (nonatomic, strong) DetailPageFooter *pageFooter;
@property (nonatomic, strong) GoodsInfoModel *goodsDetail;
@property (nonatomic, copy) NSString *isCollected;
@property (nonatomic, assign) BOOL isCart;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestGoodsInfo];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pageFooter];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
    }];
    [self.pageFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}

- (void)requestGoodsInfo {
    @weakify(self);
    NSDictionary *param = @{
                            @"goods_id":self.goods_id
                            };
    [AFNetworkTool postJSONWithUrl:goods_detail_url parameters:param success:^(id responseObject) {
        
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        
        if (code == 200) {
            GoodsInfoModel *model = [GoodsInfoModel yy_modelWithDictionary:responseObject[@"content"]];
            self.tableHead.goodsInfo = model;
            self.tableFooter.frament = model.goods_detail;
            self.goodsDetail = model;
            self.isCollected = model.isCollect;
            [self.tableView reloadData];
        }else {
            
        }
        
    } fail:^{
        
    }];
}

- (void)collectGooods {
    self.isCollected = [self.isCollected isEqualToString:@"1"]?@"2":@"1";
    NSDictionary *param = @{
                            @"goods_id":self.goods_id,
                            @"collect_type": self.isCollected
                            };
    //事件类型(1.取消收藏2.新增收藏)
    [AFNetworkTool postJSONWithUrl:shop_addOrDelGoodsCollection parameters:param success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
           ;
            [Dialog popTextAnimation:[self.isCollected isEqualToString:@"1"]?@"已取消收藏":@"收藏成功"];
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }

    } fail:^{
        
    }];
}
- (void)skipGoodsCart {
    self.tabBarController.selectedIndex = 3;
}
- (void)showAddPage {
    AddGoodsViewController *vc = [[AddGoodsViewController alloc]init];
    vc.goodsInfo = self.goodsDetail;
    vc.isCart = self.isCart;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }else{
        vc.modalPresentationStyle=UIModalPresentationCurrentContext;
    }
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsDetail.comment.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.goodsDetail.comment.count) {
        return 50;
    }
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([AssessCell class]) configuration:^(id cell) {
        [cell configCell:self.goodsDetail.comment[indexPath.row]];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.goodsDetail.comment.count) {
        MeSectionTableView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeSectionTableView" owner:self options:nil] firstObject];
        headerView.leftTitle = @"用户评价";
        headerView.rightTitle = @"查看所有评价";
        return headerView;
    }
    return nil;
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AssessCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AssessCell class])];
    [cell configCell:self.goodsDetail.comment[indexPath.row]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & get
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"AssessCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AssessCell class])];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 50;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.tableHead;
        _tableView.tableFooterView = self.tableFooter;
        
    }
    return _tableView;
}
- (DetailTableHeader *)tableHead {
    if (!_tableHead) {
        _tableHead = [[NSBundle mainBundle] loadNibNamed:@"DetailTableHeader" owner:self options:nil].firstObject;
        _tableHead.frame = CGRectMake(0, 0, kMainScreenWidth, 0);
    }
    return _tableHead;
}

- (DetailTableFooter *)tableFooter {
    if (!_tableFooter) {
        _tableFooter = [[DetailTableFooter alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 400)];
    }
    return _tableFooter;
}

- (DetailPageFooter *)pageFooter {
    if (!_pageFooter) {
        _pageFooter = [[NSBundle mainBundle] loadNibNamed:@"DetailPageFooter" owner:self options:nil].firstObject;
        @weakify(self);
        _pageFooter.buttonClickBlock = ^(NSInteger index) {
            @strongify(self);
            switch (index) {
                case 0:
                    
                    break;
                case 1:
                    [self collectGooods];
                    break;
                case 2:
                    [self skipGoodsCart];
                    break;
                case 3:
                {
                    self.isCart = YES;
                    [self showAddPage];
                }
                    break;
                case 4:
                {
                    self.isCart = NO;
                    [self showAddPage];
                }
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _pageFooter;
}
@end
