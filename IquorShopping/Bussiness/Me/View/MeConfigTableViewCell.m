//
//  MeConfigTableViewCell.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/10.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "MeConfigTableViewCell.h"
#import "MeConfigView.h"

@interface MeConfigTableViewCell ()
@property (nonatomic, strong) MeConfigView *mc1;
@property (nonatomic, strong) MeConfigView *mc2;
@property (nonatomic, strong) MeConfigView *mc3;
@property (nonatomic, strong) MeConfigView *mc4;
@property (nonatomic, strong) NSArray *mutArrs;

@end
@implementation MeConfigTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.mc1];
    [self.contentView addSubview:self.mc2];
    [self.contentView addSubview:self.mc3];
    [self.contentView addSubview:self.mc4];
    WeakObj(self);
    [self.mc1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(selfWeak.contentView);
    }];
    [self.mc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(selfWeak.contentView);
        make.left.equalTo(selfWeak.mc1.mas_right);
        make.width.equalTo(selfWeak.mc1.mas_width);
    }];
    [self.mc3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(selfWeak.contentView);
        make.left.equalTo(selfWeak.mc2.mas_right);
        make.width.equalTo(selfWeak.mc1.mas_width);
    }];
    [self.mc4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(selfWeak.contentView);
        make.left.equalTo(selfWeak.mc3.mas_right);
        make.right.equalTo(selfWeak.contentView.mas_right);
        make.width.equalTo(selfWeak.mc1.mas_width);
    }];
    
    self.mutArrs = @[self.mc1, self.mc2, self.mc3, self.mc4];
    // Initialization code
}

- (void)tapGes:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag-10000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedConfigModel:)]) {
        [self.delegate selectedConfigModel:self.cellModel[tag]];
    }
}
- (void)setCellModel:(NSArray<MeConfigModel *> *)cellModel {
    _cellModel = cellModel;
    [_cellModel enumerateObjectsUsingBlock:^(MeConfigModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MeConfigView *configView = self.mutArrs[idx];
        configView.configModel = obj;
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (MeConfigView *)mc1 {
    if (!_mc1) {
        _mc1 = [[NSBundle mainBundle]loadNibNamed:@"MeConfigView" owner:self options:nil].firstObject;
        _mc1.tag = 10000;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
        [_mc1 addGestureRecognizer:tapGes];
    }
    return _mc1;
}
- (MeConfigView *)mc2 {
    if (!_mc2) {
        _mc2 = [[NSBundle mainBundle]loadNibNamed:@"MeConfigView" owner:self options:nil].firstObject;
        _mc2.tag = 10001;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
        [_mc2 addGestureRecognizer:tapGes];
    }
    return _mc2;
}
- (MeConfigView *)mc3 {
    if (!_mc3) {
        _mc3 = [[NSBundle mainBundle]loadNibNamed:@"MeConfigView" owner:self options:nil].firstObject;
        _mc3.tag = 10002;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
        [_mc3 addGestureRecognizer:tapGes];
    }
    return _mc3;
}

- (MeConfigView *)mc4 {
    if (!_mc4) {
        _mc4 = [[NSBundle mainBundle]loadNibNamed:@"MeConfigView" owner:self options:nil].firstObject;
        _mc4.tag = 10003;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
        [_mc4 addGestureRecognizer:tapGes];
    }
    return _mc4;
}
@end
