//
//  MeCollectViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/15.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeCollectViewController.h"
#import "GoodsInfoViewController.h"
#import "CollectedCell.h"
#import "CollectModel.h"
@interface MeCollectViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isEdit;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *chosIcon;
@property (weak, nonatomic) IBOutlet UILabel *chosNums;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UITableView *collectedTable;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (nonatomic, strong) NSMutableArray *arrs;
@property (nonatomic, strong) NSMutableArray *collectArrs;
@property (nonatomic, strong) NSMutableIndexSet *indexpaths;
@property (nonatomic, assign) NSInteger page;
@end

@implementation MeCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightButton setTitle:@"管理" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(startEdit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.collectedTable.delegate = self;
    self.collectedTable.dataSource = self;
    [self.collectedTable registerNib:[UINib nibWithNibName:@"CollectedCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CollectedCell class])];
    self.collectedTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectedTable.delegate = self;
    self.collectedTable.dataSource = self;
    self.collectedTable.rowHeight = 100;
    self.collectedTable.estimatedSectionHeaderHeight = 0;
    self.collectedTable.estimatedSectionFooterHeight = 0;
    self.title = @"我的收藏";
    
    @weakify(self);
    _collectedTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.page = 1;
        self.arrs = nil;
        [self requestCouponList];
    }];
    _collectedTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.page++;
        [self requestCouponList];
    }];
}

- (void)refreshLayout {
    if (self.arrs.count) {
        self.footLayoutConstraint.constant = 45;
    }else {
        self.footLayoutConstraint.constant = 0;
    }
     [self.collectedTable reloadData];
}
- (void)requestCouponList {
    NSDictionary *param = @{@"page":@(self.page)};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_goodsCollection parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.collectedTable.mj_footer endRefreshing];
        [self.collectedTable.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            NSArray *arrs = [NSArray yy_modelArrayWithClass:[CollectModel class] json:responseObject[@"content"][@"list"]];
            if (arrs.count) {
                [self.arrs addObjectsFromArray:arrs];
                [self.collectedTable reloadData];
            }else {
                [Dialog popTextAnimation:self.page==1?@"暂无数据":@"没有下一页了"];
            }
            [self.collectedTable setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:@"空空如也"];
            [self refreshLayout];
        }else {
            [self refreshLayout];
             [self.collectedTable setTableBgViewWithCount:self.arrs.count img:@"icon_none_02" msg:@"空空如也"];
        }
    } fail:^{
       
    }];
}
- (void)startEdit:(UIButton *)sender {
    sender.selected = !sender.selected;
    [sender setTitle:sender.selected?@"完成":@"管理" forState:UIControlStateNormal];
    
    self.footView.hidden = !sender.selected;
    if (self.footView.hidden) {
        self.footLayoutConstraint.constant = 0;
    }else {
        self.footLayoutConstraint.constant = 50;
    }
    _isEdit = sender.selected;
    [self.collectedTable reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    self.arrs = nil;
    [self requestCouponList];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelChoseCollect:(UIButton *)sender {
    @weakify(self);
    if (self.collectArrs.count) {
        NSString *str = [self.collectArrs componentsJoinedByString:@","];
        NSDictionary *param = @{@"collect_ids":str};
        [AFNetworkTool postJSONWithUrl:user_delGoodsCollection parameters:param success:^(id responseObject) {
             @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                [self.arrs removeObjectsAtIndexes:self.indexpaths];
                [self.collectedTable deleteSections:self.indexpaths withRowAnimation:UITableViewRowAnimationMiddle];

            }else {
                [Dialog popTextAnimation:responseObject[@"message"]];
            }
        } fail:^{
            
        }];
    }else {
        [Dialog popTextAnimation:@"请选择要删除的收藏"];
    }
    
}

#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrs.count;
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
    CollectedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CollectedCell class])];
    CollectModel *collect = self.arrs[indexPath.section];
    cell.collect = collect;
    cell.isEdit = _isEdit;
    @weakify(self);
    cell.choseCollectBlock = ^(BOOL sel) {
        @strongify(self);
        if (sel) {
            [self.collectArrs addObject:collect.collect_id];
            [self.indexpaths addIndexes:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }else {
            if ([self.collectArrs containsObject:collect.collect_id]) {
                [self.collectArrs removeObject:collect.collect_id];
            }
            [self.indexpaths removeIndexes:[NSIndexSet indexSetWithIndex:indexPath.section]];
        }
        self.chosNums.text = [NSString stringWithFormat:@"已选(%lu)", (unsigned long)self.collectArrs.count];
        
        if (self.collectArrs.count) {
            self.chosIcon.image = [UIImage imageNamed:@"icon_normal_02"];
        }else {
            self.chosIcon.image = [UIImage imageNamed:@"icon_normal_01"];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CollectModel *collect = self.arrs[indexPath.section];
    GoodsInfoViewController *vc = [[GoodsInfoViewController alloc]init];
    vc.goods_id = collect.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)arrs {
    if (!_arrs) {
        _arrs = [NSMutableArray array];
    }
    return _arrs;
}

- (NSMutableArray *)collectArrs {
    if (!_collectArrs) {
        _collectArrs = [NSMutableArray array];
    }
    return _collectArrs;
}

- (NSMutableIndexSet *)indexpaths {
    if (!_indexpaths) {
        _indexpaths = [NSMutableIndexSet indexSet];
        
    }
    return _indexpaths;
}

@end
