//
//  AssessCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AssessCell.h"

@interface AssessCell ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *bottomview;
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIView *contanierView;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionHeightLayout;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) UILabel *leverLabel;

@end
@implementation AssessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.leverLabel];
    [self.leverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contanierView);
    }];
    [self defaultConfig];
}

- (void)defaultConfig {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = (kMainScreenWidth-70*3)/2.0;
    flowLayout.itemSize = CGSizeMake(70, 70);
    self.collection.collectionViewLayout = flowLayout;
    self.collection.dataSource = self;
    self.collection.delegate = self;
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}
- (void)configCell:(CommentModel *)model {
    if (![UIUtils isNullOrEmpty:model.avatar]) {
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"icon_head_04"]];
    }
    
    self.name.text = [UIUtils isNullOrEmpty:model.nike_name]?@"某某":model.nike_name;
    self.time.text = model.addtime;
    self.content.text = model.comment;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"★★★★★"];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor c_fa7231Color]} range:NSMakeRange(0, model.status.intValue)];
    self.leverLabel.attributedText = attStr;
    if (model.images.count) {
        self.imgs = model.images;
        [self.collection reloadData];
        self.collectionHeightLayout.constant = 70;
    }else {
        self.collectionHeightLayout.constant = 0;
    }
    
}

#pragma mark UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgs.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    [imageView sd_setImageWithURL:self.imgs[indexPath.item] placeholderImage:[UIImage imageNamed:@""]];
    [cell.contentView addSubview:imageView];
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)leverLabel {
    if (!_leverLabel) {
        _leverLabel = [[UILabel alloc]init];
        _leverLabel.textAlignment = NSTextAlignmentCenter;
        _leverLabel.textColor = [UIColor c_cccColor];
        _leverLabel.text = @"★★★★★";
    }
    return _leverLabel;
}
@end
