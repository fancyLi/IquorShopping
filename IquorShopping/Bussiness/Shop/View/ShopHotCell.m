//
//  ShopHotCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopHotCell.h"
#import "SiginCell.h"
@interface ShopHotCell ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *hotCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *shosBtn;

@end
@implementation ShopHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configHotUI];
    
}
#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width/3.0, 180);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SiginCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SiginCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)configHotUI {
    
    [self.hotCollectionView registerNib:[UINib nibWithNibName:@"SiginCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SiginCell class])];
    self.hotCollectionView.dataSource = self;
    self.hotCollectionView.delegate = self;
}
- (IBAction)chosClick:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
