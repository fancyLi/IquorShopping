//
//  ShopTableHeaderView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopTableHeaderView.h"
#import "SDCycleScrollView.h"
@interface ShopTableHeaderView ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end
@implementation ShopTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScrollView];
    }
    return self;
}

- (void)setBanners:(NSArray<Banner *> *)banners {
    _banners = banners;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_banners.count];
    for (Banner *banner in _banners) {
        [arr addObject:banner.banner];
    }
    self.cycleScrollView.imageURLStringsGroup = arr;
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.seletedBlock) {
        self.seletedBlock(self.banners[index]);
    }
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:self.bounds];
        _cycleScrollView.autoScrollTimeInterval = 5;
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}
@end
