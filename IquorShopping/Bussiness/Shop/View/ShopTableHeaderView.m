//
//  ShopTableHeaderView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopTableHeaderView.h"
#import "BannerCell.h"

#define kScrollAnimationKey @"scrollAnimation"
@interface ShopTableHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end
@implementation ShopTableHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_pageControl.superview) {
        [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-5);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        
        if (self.pageControl.numberOfPages > 1) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            });
        }
    }
}

- (void)dealloc
{
    [self stopPlay];
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.pageControl.numberOfPages = self.banners.count <= 1 ? : (self.banners.count - 2);
    self.pageControl.currentPage = 0;
    
    return self.banners.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BannerCell class]) forIndexPath:indexPath];
    
    [cell configCell:self.banners[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self stopPlay];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    NSInteger currentPage = fabs(scrollView.contentOffset.x/scrollView.frame.size.width);
    
    if (currentPage == 0) {
        currentPage = self.banners.count - 3;
        
        self.collectionView.contentOffset = CGPointMake((self.banners.count-2) * self.collectionView.frame.size.width, 0);
    }
    else if (currentPage == self.banners.count-1) {
        currentPage = 0;
        
        self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width, 0);
    }
    else {
        currentPage--;
    }
    
    self.pageControl.currentPage = currentPage;
    
    [self startPlay];
}

#pragma mark - public

- (void)reloadData
{
    [self stopPlay];
    
    [self.collectionView reloadData];
    
    [self startPlay];
}

#pragma mark - private

- (void)setup
{
    _banners = @[];
    _hideTitleLabel = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:NSStringFromClass([BannerCell class])];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
}
- (void)setBanners:(NSArray<Banner *> *)banners {
    _banners = banners;
    if (_banners.count) {
        [self addSubview:_collectionView];
        [self addSubview:_pageControl];
    }
    if (_banners.count > 1) {
        NSMutableArray *newItems = [[NSMutableArray alloc] initWithArray:_banners];
        [newItems insertObject:_banners.lastObject atIndex:0];
        [newItems addObject:_banners.firstObject];
        _banners = newItems;
    }
}


- (void)startPlay
{
    if (self.autoPlayingInterval > 0 && self.banners.count > 1) {
        [self stopPlay];
        [self performSelector:@selector(next) withObject:nil afterDelay:self.autoPlayingInterval];
    }
}

- (void)stopPlay
{
    [self.collectionView.layer removeAnimationForKey:kScrollAnimationKey];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(next) object:nil];
}

- (void)next
{
    NSInteger currentPage = self.pageControl.currentPage;
    
    if (self.pageControl.currentPage == (self.banners.count - 3)) {
        currentPage = 0;
    }
    else {
        currentPage++;
    }
    
    self.collectionView.contentOffset = CGPointMake((currentPage + 1) * self.collectionView.frame.size.width, 0);
    [self.collectionView.layer addAnimation:[self scrollBannerAnimation] forKey:kScrollAnimationKey];
    self.pageControl.currentPage = currentPage;
    
    [self startPlay];
}

- (CATransition *)scrollBannerAnimation
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.75f;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    return animation;
}

@end
