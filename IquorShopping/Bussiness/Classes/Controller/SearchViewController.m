//
//  SearchViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "SearchViewController.h"
#import "NavSegmentBar.h"
#import "SiginCell.h"
#import "GoodsInfoViewController.h"
@interface SearchViewController ()<UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, copy) NSString *priceSort;
@property (nonatomic, copy) NSString *volumeSort;
@property (nonatomic, strong) NavSegmentBar *segmentBar;
@property (nonatomic, strong) UICollectionView *classView;
@property (nonatomic, strong) NSMutableArray *goods;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor c_f6f6Color];
    self.navigationItem.titleView = self.searchBar;
    [self initConfig];
}
- (void)initConfig {
    self.page = 1;
    
    self.priceSort = @"";
    self.volumeSort = @"";
}
- (void)requertClassInfo {
    //代表类型 1.热门推荐2.最新产品3.分类产品4.搜索关键词
    //商品价格排序 1.升序2.降序
    //商品价格排序 1.升序2.降序
    @weakify(self);
    NSDictionary *param = @{@"page":@(self.page),
                            @"type":@"4",
                            @"goods_price_sort":self.priceSort,
                            @"sales_volume_sort":self.volumeSort,
                            @"cat_id":[UIUtils isNullOrEmpty:self.cat_id]?@"":self.cat_id,
                            @"key_words":[UIUtils isNullOrEmpty:self.searchBar.text]?@"":self.searchBar.text
                            };
    [AFNetworkTool postJSONWithUrl:shop_goodsList parameters:param success:^(id responseObject) {
        @strongify(self);
        [self.classView.mj_footer endRefreshing];
        [self.classView.mj_header endRefreshing];
        
        NSInteger code = [responseObject[@"code"] integerValue];
       
        if (code == 200) {
            AllInfo *allInfo = [AllInfo yy_modelWithJSON:responseObject[@"content"]];
            [self.goods addObjectsFromArray:allInfo.list];
            [self.classView reloadData];
            [self.view addSubview:self.segmentBar];
            [self.view addSubview:self.classView];
            
        }else {
             [Dialog popTextAnimation:responseObject[@"message"]];
        }
        [self.classView setTableBgViewWithCount:self.goods.count img:@"icon_none_02" msg:@"空空如也..."];
    } fail:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goods.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SiginCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SiginCell class]) forIndexPath:indexPath];
    [cell configGoodsInfo:self.goods[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsInfoViewController *vc = [[GoodsInfoViewController alloc]init];
    GoodsInfoModel *model = self.goods[indexPath.item];
    vc.goods_id = model.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.page = 1;
    self.goods = nil;
    [self requertClassInfo];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}
#pragma mark set & get
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth-30, 44)];
        _searchBar.delegate = self;
        _searchBar.tintColor = UIColorFromRGB(0x3194F9);
        _searchBar.placeholder = @"按商品关键词搜索";
        UIView *searchTextField =  [[[_searchBar.subviews firstObject] subviews] lastObject];
        searchTextField.backgroundColor = UIColorFromRGB(0xEDEDED);
        [_searchBar becomeFirstResponder];
    }
    return _searchBar;
}
- (UICollectionView *)classView {
    if (!_classView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        CGFloat wh =(kMainScreenWidth-1)/2;
        flowLayout.itemSize = CGSizeMake(wh, wh);
        _classView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 108, kMainScreenWidth, kMainScreenHeight-108) collectionViewLayout:flowLayout];
        _classView.backgroundColor = [UIColor c_f6f6Color];
        [_classView registerNib:[UINib nibWithNibName:@"SiginCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SiginCell class])];
        _classView.dataSource = self;
        _classView.delegate = self;
        @weakify(self);
        _classView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            self.page = 1;
            self.goods = nil;
            [self requertClassInfo];
        }];
        _classView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            self.page++;
            [self requertClassInfo];
        }];
    }
    return _classView;
}
- (NavSegmentBar *)segmentBar {
    if (!_segmentBar) {
        WeakObj(self);
        _segmentBar = [[NSBundle mainBundle]loadNibNamed:@"NavSegmentBar" owner:self options:nil].firstObject;
        _segmentBar.segmentSelectedBlock = ^(NSString *priceSort, NSString *volumeSort) {
            selfWeak.priceSort = priceSort;
            selfWeak.volumeSort = volumeSort;
            selfWeak.page = 1;
            selfWeak.goods = nil;
            [selfWeak requertClassInfo];
        };
        
    }
    return _segmentBar;
}
- (NSMutableArray *)goods {
    if (!_goods) {
        _goods = [NSMutableArray array];
    }
    return _goods;
}
@end
