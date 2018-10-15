//
//  ShopAreaViewController.m
//  IquorShopping
//
//  Created by nanli on 2018/10/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ShopAreaViewController.h"
#import "ClassesViewController.h"
#import "HomePageModel.h"
#import "ClassCell.h"

@interface ShopAreaViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *classView;

@property (nonatomic, strong) NSArray <GoodsArea *> *areas;

@end

@implementation ShopAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专区";
    [self.view addSubview:self.classView];
    [self.classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [self requestClssInfo];
    
    // Do any additional setup after loading the view.
}

- (void)requestClssInfo {
    WeakObj(self);
    [AFNetworkTool postJSONWithUrl:shop_areaList parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code == 200) {
            selfWeak.areas = [NSArray yy_modelArrayWithClass:[GoodsArea class] json:responseObject[@"content"][@"list"]];
            [selfWeak.classView reloadData];
            
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
    } fail:^{
        
    }];
}
#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.areas.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ClassCell class]) forIndexPath:indexPath];
    cell.prefecture = self.areas[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassesViewController *vc = [[ClassesViewController alloc] init];
    vc.goodsArea = self.areas[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark set & ger
- (UICollectionView *)classView {
    if (!_classView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat wh = 120;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = (kMainScreenWidth-3*wh)/3;
        flowLayout.itemSize = CGSizeMake(wh, wh);
        _classView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _classView.backgroundColor = [UIColor whiteColor];
        [_classView registerNib:[UINib nibWithNibName:@"ClassCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([ClassCell class])];
        _classView.dataSource = self;
        _classView.delegate = self;
    }
    return _classView;
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
