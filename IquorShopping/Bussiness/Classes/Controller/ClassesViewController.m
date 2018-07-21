//
//  ClassesViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ClassesViewController.h"
#import "SiginViewController.h"
#import "NavSearchBar.h"
#import "ClassCell.h"
#import "ClassInfoModel.h"
@interface ClassesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *classView;
@property (nonatomic, strong) NavSearchBar *navSearchBar;
@property (nonatomic, strong) NSArray *classes;
@end

@implementation ClassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.classView];
    self.navigationItem.titleView = self.navSearchBar;
    [self requestClssInfo];
}

- (void)requestClssInfo {
    WeakObj(self);
    [AFNetworkTool postJSONWithUrl:shop_goodsCatList parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            selfWeak.classes = [NSArray yy_modelArrayWithClass:[ClassInfoModel class] json:responseObject[@"content"][@"list"]];
            [selfWeak.classView reloadData];
            
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}
#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.classes.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ClassCell class]) forIndexPath:indexPath];
    [cell setClassInfo:self.classes[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassInfoModel *infoModel = self.classes[indexPath.item];
    SiginViewController *siginVC = [[SiginViewController alloc]init];
    siginVC.cat_id = infoModel.cat_id;
    siginVC.title = infoModel.cat_name;
    siginVC.type = @"3";
    siginVC.title = infoModel.cat_name;
    [self.navigationController pushViewController:siginVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & ger
- (UICollectionView *)classView {
    if (!_classView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat wh = 120;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = (kMainScreenWidth-3*wh)/3;
        flowLayout.itemSize = CGSizeMake(wh, wh);
        _classView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _classView.backgroundColor = [UIColor whiteColor];
        [_classView registerNib:[UINib nibWithNibName:@"ClassCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ClassCell class])];
        _classView.dataSource = self;
        _classView.delegate = self;
    }
    return _classView;
}

- (NavSearchBar *)navSearchBar {
    if (!_navSearchBar) {
        _navSearchBar = [[NSBundle mainBundle] loadNibNamed:@"NavSearchBar" owner:self options:nil].firstObject;
    }
    return _navSearchBar;
}

@end
