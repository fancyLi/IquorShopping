//
//  AreaChoseViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/6.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AreaChoseViewController.h"
#import "ChoseAreaModel.h"
#import "CityModel.h"
#import "AreaModel.h"
typedef NS_ENUM(NSInteger, AreaChose) {
    KProvince = 0,
    KCity,
    KArea
};

@interface AreaChoseViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    provinceModel *_provinceModel;
    CityModel *_cityModel;
    ChoseAreaModel *_choseAreaModel;
}
@property (weak, nonatomic) IBOutlet UIButton *province;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UIButton *area;
@property (weak, nonatomic) IBOutlet UITableView *areaTableview;
@property (nonatomic, assign) AreaChose choseArea;

@end

@implementation AreaChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    _choseAreaModel = [[ChoseAreaModel alloc]init];
    [self.areaTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.areaTableview.backgroundColor = [UIColor whiteColor];
    self.areaTableview.dataSource = self;
    self.areaTableview.delegate = self;
    self.areaTableview.tableFooterView = [UIView new];
}

- (IBAction)closePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.choseArea == KProvince) {
        return self.areaArrs.count;
    }else if (self.choseArea == KCity) {
        return _provinceModel.sub.count;
    }else {
        return _cityModel.sub.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (self.choseArea == KProvince) {
        provinceModel *province = self.areaArrs[indexPath.row];
        cell.textLabel.text = province.region_name;
    }else if (self.choseArea == KCity) {
        CityModel *city = _provinceModel.sub[indexPath.row];
        cell.textLabel.text = city.region_name;
    }else {
        AreaModel *area = _cityModel.sub[indexPath.row];
        cell.textLabel.text = area.region_name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.choseArea == KProvince) {
        self.choseArea = KCity;
        _provinceModel = self.areaArrs[indexPath.row];
        _choseAreaModel.areaStr = _provinceModel.region_name;
        _choseAreaModel.provinceId = _provinceModel.region_id;
        [self.province setTitle:_provinceModel.region_name forState:UIControlStateNormal];
        [self.province setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
        [self.areaTableview reloadData];
    }else if (self.choseArea == KCity) {
        self.choseArea = KArea;
        _cityModel = _provinceModel.sub[indexPath.row];
        _choseAreaModel.cityId = _cityModel.region_id;
        if (![_choseAreaModel.areaStr isEqualToString:_cityModel.region_name] && ![_choseAreaModel.areaStr containsString:_cityModel.region_name]) {
            _choseAreaModel.areaStr = [NSString stringWithFormat:@"%@  %@", _choseAreaModel.areaStr, _cityModel.region_name];
        }
        
        [self.city setTitle:_cityModel.region_name forState:UIControlStateNormal];
        [self.city setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
        [self.areaTableview reloadData];
    }else {
        AreaModel *areaModel = _cityModel.sub[indexPath.row];
        _choseAreaModel.districtId = areaModel.region_id;
        
        _choseAreaModel.areaStr = [NSString stringWithFormat:@"%@  %@", _choseAreaModel.areaStr, areaModel.region_name];
        
        if (self.selectedAreaBlock) {
            self.selectedAreaBlock(_choseAreaModel);
        }
        [self.area setTitle:areaModel.region_name forState:UIControlStateNormal];
        [self.area setTitleColor:[UIColor c_333Color] forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
