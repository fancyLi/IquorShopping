//
//  MeCommenCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeCommenCell.h"
@interface MeCommenCell ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIView *colContainer;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *starContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colLayoutConstraint;
@property (nonatomic, strong) UILabel *leverLabel;
@property (nonatomic, strong) NSArray *imgs;

@end
@implementation MeCommenCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.leverLabel];
    [self.leverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.starContainer);
    }];
    [self defaultConfig];
    // Initialization code
}

- (void)defaultConfig {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = (kMainScreenWidth-70*3)/2.0;
    flowLayout.itemSize = CGSizeMake(70, 70);
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}

- (void)setComment:(MeCommentModel *)comment {
    _comment = comment;
    if (![UIUtils isNullOrEmpty:_comment.avatar]) {
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:_comment.avatar] placeholderImage:[UIImage imageNamed:@"icon_head_04"]];
    }
    
    self.nick.text = [UIUtils isNullOrEmpty:_comment.nick_name]?@"某某":_comment.nick_name;
    self.time.text = _comment.addtime;
    self.content.text = _comment.comment;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"★★★★★"];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor c_fa7231Color]} range:NSMakeRange(0, _comment.status.intValue)];
    self.leverLabel.attributedText = attStr;
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_comment.goods_image]];
    self.goodsName.text = _comment.goods_name;
    self.goodsPrice.text = [NSString stringWithFormat:@"￥%@", _comment.goods_price];
    if (_comment.images.count) {
        self.imgs = _comment.images;
        [self.collectionView reloadData];
        self.colLayoutConstraint.constant = 70;
    }else {
        self.colLayoutConstraint.constant = 0;
    }
    
}

#pragma mark UICollectionViewDelegateFlowLayout & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgs.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    [imageView sd_setImageWithURL:self.imgs[indexPath.item] placeholderImage:[UIImage imageNamed:@"default_icon"]];
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
