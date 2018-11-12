//
//  ShopLoveCell.m
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopLoveCell.h"

#import "ShopLoverCell.h"

#import "SDCycleScrollView.h"

#import "HomePageModel.h"

#import <YYCategories/UIControl+YYAdd.h>

#import <YYCategories/UITableView+YYAdd.h>

@interface ShopLoveCell () <UITableViewDataSource, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *sycleScrollView;

@property (weak, nonatomic) IBOutlet UILabel *donateTotal;

@property (weak, nonatomic) IBOutlet UIButton *moreDonater;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView2;
/**  */
@property (nonatomic, strong) CADisplayLink *displayLink;
/**  */
@property (nonatomic, assign) CGFloat offy;
@end

@implementation ShopLoveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
}

- (void)setHomePage:(HomePageModel *)homePage {
    _homePage = homePage;
    CGFloat total = _homePage.total_giving.floatValue;
    self.donateTotal.text = [NSString stringWithFormat:@"%.2f",  total];
    [self.tableView reloadData];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_homePage.love_banner.count];
    for (Banner *banner in _homePage.love_banner) {
        [arr addObject:banner.banner];
    }
    self.sycleScrollView.imageURLStringsGroup = arr;
    

    if (!_homePage.love_list.count) {
        self.stackView.hidden = YES;
        self.stackView2.hidden = YES;
        return;
    }

    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(scroOffy) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
   
    
}

- (void)scroOffy {
    if (self.offy>self.tableView.contentSize.height-60*3) {
        self.offy = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView setContentOffset:CGPointMake(0, self.offy) animated:NO];
        });
    }else {
        self.offy += 1;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView setContentOffset:CGPointMake(0, self.offy) animated:YES];
        });
    }
    
}

- (void)configUI {
    self.sycleScrollView.autoScrollTimeInterval = 4;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopLoverCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ShopLoverCell class])];
    self.tableView.rowHeight = 60;
    
    @weakify(self);
    [self.moreDonater addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.moreDonate) {
            self.moreDonate();
        }
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homePage.love_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopLoverCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopLoverCell class])];
    cell.lover = self.homePage.love_list[indexPath.row];
    return cell;
}

#pragma mark SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
   
}
@end
