//
//  ShowPictureView.m
//  zhihuiyanglao
//
//  Created by admin on 2018/1/23.
//  Copyright © 2018年 iflytek. All rights reserved.
//

#import "ShowPictureView.h"
#import "UIButton+WebCache.h"


@interface ShowPictureView ()
{
    CGFloat kPicWH;
    CGFloat kPicSpace;
}
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *addPicBtn;
@property (nonatomic, strong) NSMutableArray *allButtonsArray;
@end


@implementation ShowPictureView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
        _isURL = YES;
        kPicWH = ([UIScreen mainScreen].bounds.size.width-50)/4;
        kPicSpace = 10;
        self.MaxNum = 6;
    }
    return self;
}

- (void)setIsNeedAddBtn:(BOOL)isNeedAddBtn{
    _isNeedAddBtn = isNeedAddBtn;
    if (isNeedAddBtn) {
        self.addPicBtn.hidden = NO;
        [self addSubview:self.addPicBtn];
        [self showPictureViewLayout];
    }else{
        self.addPicBtn.hidden = YES;
        if (self.addPicBtn.superview) {
            [self.addPicBtn removeFromSuperview];
        }
    }
}

- (void)setPicArray:(NSArray *)picArray{
    _picArray = picArray;
    if (!self.allButtonsArray) {
        self.allButtonsArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    //先移除
    [self.allButtonsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.allButtonsArray removeAllObjects];
    //在添加
    for (int i = 0; i < picArray.count; i++) {
        UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        picBtn.backgroundColor = [UIColor whiteColor];
        if (_isURL) {
             [picBtn sd_setBackgroundImageWithURL:picArray[i] forState:UIControlStateNormal];
        }else{
             [picBtn setBackgroundImage:picArray[i] forState:UIControlStateNormal];
        }
        picBtn.tag = 100+i;
        [picBtn addTarget:self action:@selector(picBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:picBtn];
        [self.allButtonsArray addObject:picBtn];
    }
    [self showPictureViewLayout];
}

- (void)showPictureViewLayout{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    [array addObjectsFromArray:self.allButtonsArray];
    if (self.isNeedAddBtn) {
        if (array.count >= self.MaxNum) {
             self.addPicBtn.hidden = YES;
        }else{
            self.addPicBtn.hidden = NO;
        }
        [array addObject:self.addPicBtn];
    }
    int maxCountRow = 4; //每行4个
    CGFloat maxH = 0;
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = array[i];
        int loc = i % maxCountRow;
        int row = i / maxCountRow;
        CGFloat btnX = loc * (kPicWH + kPicSpace);
        CGFloat btnY = row * (kPicWH + kPicSpace);
        btnX += kPicSpace;
        btnY += kPicSpace;
        btn.frame = CGRectMake(btnX, btnY, kPicWH, kPicWH);
        maxH = CGRectGetMaxY(btn.frame);
    }
    CGRect kRect = self.frame;
    kRect.size.height = maxH + kPicSpace;
    self.frame = kRect;
    self.line.frame = CGRectMake(0, self.frame.size.height-1, kMainScreenWidth, 1);
}
#pragma mark - 点击事件
- (void)addPicBtnClick{
    if ([_delegate respondsToSelector:@selector(addButtonClick:)]) {
        [_delegate addButtonClick:self];
    }
}

- (void)picBtnClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(showPicClick:clickedPicTag:)]) {
        int index = (int)sender.tag-100;
        [_delegate showPicClick:self clickedPicTag:index];
    }
}

#pragma mark - set&get
- (UIButton *)addPicBtn{
    if (!_addPicBtn) {
        _addPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addPicBtn.frame = CGRectMake(kPicSpace, kPicSpace, kPicWH, kPicWH);
        [_addPicBtn setBackgroundImage:[UIImage imageNamed:@"icon_30"] forState:UIControlStateNormal];
        [_addPicBtn addTarget:self action:@selector(addPicBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addPicBtn;
}
- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor c_f6f6Color];
    }
    return _line;
}

@end
