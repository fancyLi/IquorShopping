//
//  ShopConfigCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopConfigCell.h"
#import "ClassCell.h"
@interface ShopConfigCell ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *configCollection;
@property (weak, nonatomic) IBOutlet UICollectionView *configCollectionView;
@property (nonatomic, strong) NSMutableArray *goodsCats;
@end
@implementation ShopConfigCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configUI];
}
- (void)configUI {
    [self.configCollectionView registerNib:[UINib nibWithNibName:@"ClassCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ClassCell class])];
    self.configCollectionView.dataSource = self;
    self.configCollectionView.delegate = self;
    self.configCollectionView.scrollEnabled = NO;
}
- (void)configCatInfo:(NSArray<ClassInfoModel *> *)cats {
    if (cats) {
        ClassInfoModel *info = [[ClassInfoModel alloc]init];
        info.cat_id = @"0";
        info.cat_name = @"领券";
        info.cat_image = @"icon_09 ";
        ClassInfoModel *info2 = [[ClassInfoModel alloc]init];
        info2.cat_id = @"0";
        info2.cat_name = @"全部分类";
        info2.cat_image = @"icon_10";
        
        self.goodsCats = [cats mutableCopy];
        [self.goodsCats addObject:info];
        [self.goodsCats addObject:info2];
        [self.configCollectionView reloadData];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.bounds.size.width/4.0, self.bounds.size.height/2.0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsCats.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ClassCell class]) forIndexPath:indexPath];
    [cell setClassInfo:self.goodsCats[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.configBlock) {
        self.configBlock(self.goodsCats[indexPath.item]);
    }
}



@end
