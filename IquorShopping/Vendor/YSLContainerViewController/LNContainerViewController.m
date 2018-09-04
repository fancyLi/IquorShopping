//
//  LNContainerViewController.m
//  ContainerVC
//
//  Created by linan on 16/10/10.
//  Copyright © 2016年 iflytek. All rights reserved.
//

#import "LNContainerViewController.h"

static const CGFloat kYSLScrollMenuViewHeight = 35;
@interface LNContainerViewController ()
@property (nonatomic, strong) UISegmentedControl *contentSegmentedControl;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation LNContainerViewController

- (id)initWithControllers:(NSArray *)controllers
     parentViewController:(UIViewController *)parentViewController {
    self = [super init];
    if (self) {
        
        [parentViewController addChildViewController:self];
        [self didMoveToParentViewController:parentViewController];
        
        _titles = [[NSMutableArray alloc] init];
        _childControllers = [[NSMutableArray alloc] init];
        _childControllers = [controllers mutableCopy];
        
        NSMutableArray *titles = [NSMutableArray array];
        for (UIViewController *vc in _childControllers) {
            [titles addObject:[vc valueForKey:@"title"]];
        }
        _titles = [titles mutableCopy];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // setupViews
    UIView *viewCover = [[UIView alloc]init];
    [self.view addSubview:viewCover];
    
    // ContentScrollview setup
    _contentScrollView = [[UIScrollView alloc]init];
    _contentScrollView.frame = CGRectMake(0, +kYSLScrollMenuViewHeight, self.view.frame.size.width, self.view.frame.size.height - kYSLScrollMenuViewHeight);
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.scrollEnabled = NO;
    
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.scrollsToTop = NO;
    [self.view addSubview:_contentScrollView];
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * self.childControllers.count, _contentScrollView.frame.size.height);
    
    // ContentViewController setup
    for (int i = 0; i < self.childControllers.count; i++) {
        id obj = [self.childControllers objectAtIndex:i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            CGFloat scrollWidth = _contentScrollView.frame.size.width;
            CGFloat scrollHeght = _contentScrollView.frame.size.height;
            controller.view.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeght);
            [_contentScrollView addSubview:controller.view];
        }
    }

    _contentSegmentedControl = [[UISegmentedControl alloc]initWithItems:_titles];
    _contentSegmentedControl.frame = CGRectMake(20, 0, self.view.frame.size.width - 40, kYSLScrollMenuViewHeight);
    _contentSegmentedControl.selectedSegmentIndex = 0;
    [_contentSegmentedControl addTarget:self action:NSSelectorFromString(@"changeCurrentIndexSegmentControl:") forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_contentSegmentedControl];
    [self scrollMenuViewSelectedIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- private
- (void)changeCurrentIndexSegmentControl:(UISegmentedControl *)segmentControl {
    [self scrollMenuViewSelectedIndex:segmentControl.selectedSegmentIndex];
}
- (void)setChildViewControllerWithCurrentIndex:(NSInteger)currentIndex
{
    for (int i = 0; i < self.childControllers.count; i++) {
        id obj = self.childControllers[i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            if (i == currentIndex) {
                [controller willMoveToParentViewController:self];
                [self addChildViewController:controller];
                [controller didMoveToParentViewController:self];
            } else {
                [controller willMoveToParentViewController:self];
                [controller removeFromParentViewController];
                [controller didMoveToParentViewController:self];
            }
        }
    }
}

#pragma mark -- YSLScrollMenuView Delegate

- (void)scrollMenuViewSelectedIndex:(NSInteger)index
{
    [_contentScrollView setContentOffset:CGPointMake(index * _contentScrollView.frame.size.width, 0.) animated:YES];
    
    [self setChildViewControllerWithCurrentIndex:index];
    
    if (index == self.currentIndex) { return; }
    self.currentIndex = index;
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(containerViewItemIndex:currentController:)]) {
//        [self.delegate containerViewItemIndex:self.currentIndex currentController:_childControllers[self.currentIndex]];
//    }
}

@end
