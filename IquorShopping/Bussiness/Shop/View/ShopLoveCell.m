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
}
- (void)configUI {
    self.sycleScrollView.autoScrollTimeInterval = 4;
    self.tableView.dataSource = self;
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
