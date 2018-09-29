//
//  DetailTableHeader.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/18.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "DetailTableHeader.h"
#import "SDCycleScrollView.h"
@interface DetailTableHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodsDes;
@property (weak, nonatomic) IBOutlet UILabel *goodsClas;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label03;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsSpec;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end
@implementation DetailTableHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.goodsIcon);
    }];
    
}

- (void)setGoodsInfo:(GoodsInfoModel *)goodsInfo {
    _goodsInfo = goodsInfo;
    self.cycleScrollView.imageURLStringsGroup = _goodsInfo.goods_pics;
    self.goodsDes.text = _goodsInfo.goods_name;
    self.goodsPrice.text = [NSString stringWithFormat:@"￥%@",_goodsInfo.goods_price];
    self.goodsSpec.text = [NSString stringWithFormat:@"规格：%@", _goodsInfo.attr_name];
    for (int i = 0; i<_goodsInfo.tag_list.count; i++) {
        switch (i) {
            case 0:
                {
                    self.goodsClas.hidden = NO;
                    self.goodsClas.text = _goodsInfo.tag_list[i][@"tag_name"];
                }
                break;
            case 1:
            {
                self.label02.hidden = NO;
                self.label02.text = _goodsInfo.tag_list[i][@"tag_name"];
            }
                break;
            case 2:
            {
                self.label03.hidden = NO;
                self.label03.text = _goodsInfo.tag_list[i][@"tag_name"];
            }
                break;
                
            default:
                break;
        }
    }
}


- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc]init];
        _cycleScrollView.autoScrollTimeInterval = 5;
    }
    return _cycleScrollView;
}

@end
