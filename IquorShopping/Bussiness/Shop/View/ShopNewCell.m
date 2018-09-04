//
//  ShopNewCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopNewCell.h"
#import "SiginCell.h"
@interface ShopNewCell ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *newsCollectionView;
@property (nonatomic, strong) NSArray *goodsNew;
@end
@implementation ShopNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configNewsUI];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (self.operatorHotLookBlock) {
        self.operatorHotLookBlock();
    }
}
- (void)configNewInfo:(NSArray<GoodsInfoModel *> *)goodsNew {
    self.goodsNew = goodsNew;
    [self.newsCollectionView reloadData];
}
- (CGFloat)getCellHeight:(NSArray<GoodsInfoModel *> *)goodsNew {
    NSInteger m = goodsNew.count/2;
    NSInteger n = goodsNew.count%2;
    return (m+n)*250+93;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.bounds.size.width-2)/2.0, 250);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsNew.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SiginCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SiginCell class]) forIndexPath:indexPath];
    [cell configGoodsInfo:self.goodsNew[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsInfoModel *model = self.goodsNew[indexPath.item];
    if (self.operatorHotCellBlock) {
        self.operatorHotCellBlock(model);
    }
}
- (void)configNewsUI {
    
    
    [self.newsCollectionView registerNib:[UINib nibWithNibName:@"SiginCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SiginCell class])];
    self.newsCollectionView.dataSource = self;
    self.newsCollectionView.delegate = self;
    self.newsCollectionView.scrollEnabled = NO;
}

@end
