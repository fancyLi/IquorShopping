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

@end

@implementation ShopLoveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
}

- (void)setHomePage:(HomePageModel *)homePage {
    _homePage = homePage;
    self.donateTotal.text = _homePage.total_giving;
    [self.tableView reloadData];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_homePage.love_banner.count];
    for (Banner *banner in _homePage.love_banner) {
        [arr addObject:banner.banner];
    }
    self.sycleScrollView.imageURLStringsGroup = arr;
    

    if (@available(iOS 10.0, *)) {
        __block int curIndex = 0;
        [NSTimer scheduledTimerWithTimeInterval:2.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSInteger count = self.homePage.love_list.count;
            curIndex ++;
            if (curIndex==count) {
                curIndex = 0;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView scrollToRow:curIndex inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:NO];
                    
                });
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView scrollToRow:curIndex inSection:0 atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    
                });
            }
           
            
        }];
    } else {

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
