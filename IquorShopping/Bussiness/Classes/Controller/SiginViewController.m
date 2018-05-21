//
//  SiginViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "SiginViewController.h"
#import "GoodsViewController.h"
#import "NavSegmentBar.h"
#import "SiginCell.h"
@interface SiginViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NavSegmentBar *segmentBar;
@property (nonatomic, strong) UICollectionView *classView;
@end

@implementation SiginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"白酒";
    self.view.backgroundColor = [UIColor c_f6f6Color];
    [self.view addSubview:self.classView];
    [self.view addSubview:self.segmentBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SiginCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SiginCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:[GoodsViewController new] animated:YES];
}
#pragma mark set & get
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
    }
    return _classView;
}
- (NavSegmentBar *)segmentBar {
    if (!_segmentBar) {
        _segmentBar = [[NSBundle mainBundle]loadNibNamed:@"NavSegmentBar" owner:self options:nil].firstObject;
        
    }
    return _segmentBar;
}

@end
