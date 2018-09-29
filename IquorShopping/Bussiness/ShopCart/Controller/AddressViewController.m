//
//  AddressViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/5.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AddressViewController.h"
#import "AreaChoseViewController.h"
#import "ChoseAreaModel.h"
#import "AddressInfoCell.h"
#import "CityModel.h"
#import "AddressModel.h"

@interface AddressViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isDefault;
    UIButton *_addressBtn;
}
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic, strong) NSArray *leftArrs;
@property (nonatomic, strong) NSArray *placeholderArrs;
@property (nonatomic, strong) NSArray *areaArrs;
@property (nonatomic, strong) NSMutableArray<UITextField *> *inputs;
@property (nonatomic, strong) ChoseAreaModel *choseArea;
@property (nonatomic, strong) AddressModel *adress;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self judgeEdit]) {
        [self requestEditInfo];
    }
    [self configInfoUI];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)judgeEdit {
    return ![UIUtils isNullOrEmpty:self.aid];
}
- (void)configInfoUI {
    self.title = [self judgeEdit]?@"新增收货地址":@"编辑收货地址";
    self.inputs = [NSMutableArray arrayWithCapacity:0];
    self.infoTableView.dataSource = self;
    self.infoTableView.delegate = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.infoTableView registerNib:[UINib nibWithNibName:@"AddressInfoCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AddressInfoCell class])];
}

- (void)requestEditInfo {
    NSDictionary *param = @{@"aid": self.aid};
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_addressInfo parameters:param success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.adress = [AddressModel yy_modelWithDictionary:responseObject[@"content"][@"address_info"]];
            self.choseArea = [[ChoseAreaModel alloc]init];
            self.choseArea.provinceId = self.adress.province;
            self.choseArea.cityId = self.adress.city;
            self.choseArea.districtId = self.adress.district;
            self.choseArea.areaStr  = self.adress.contact_addr;
            [self.infoTableView reloadData];
        }
    } fail:^{
        
    }];
}
- (IBAction)saveClick:(UIButton *)sender {
    
    if ([UIUtils isNullOrEmpty:self.inputs[0].text]) {
        [Dialog popTextAnimation:@"请填写收货人姓名"];
    }else if ([UIUtils isNullOrEmpty:self.inputs[1].text]) {
        [Dialog popTextAnimation:@"请填写收货人联系方式"];
    }else if ([UIUtils isNullOrEmpty:self.inputs[2].text]) {
        [Dialog popTextAnimation:@"请选择区域"];
    }else if ([UIUtils isNullOrEmpty:self.inputs[3].text]) {
        [Dialog popTextAnimation:@"请填写详细地址"];
    }else {
        @weakify(self);
        NSDictionary *param;
        if ([self judgeEdit]) {
            param = @{@"contact_name":self.inputs[0].text,
                      @"contact_tel":self.inputs[1].text,
                      @"province":self.choseArea.provinceId,
                      @"city":self.choseArea.cityId,
                      @"district":self.choseArea.districtId,
                      @"contact_addr":self.inputs[3].text,
                      @"default": _isDefault ? @"2":@"1",
                      @"aid":self.aid
                      };
        }else {
          param = @{@"contact_name":self.inputs[0].text,
                    @"contact_tel":self.inputs[1].text,
                    @"province":self.choseArea.provinceId,
                    @"city":self.choseArea.cityId,
                    @"district":self.choseArea.districtId,
                    @"contact_addr":self.inputs[3].text,
                    @"default": _isDefault ? @"2":@"1"
                    };
        }
        
       
        NSString *url = [self judgeEdit] ?user_editAddr_url:save_address_url;
        [AFNetworkTool postJSONWithUrl:url parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            [Dialog popTextAnimation:responseObject[@"message"]];
            if (code == 200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else {
            }
        } fail:^{
            
        }];
    }
}

- (void)clickDefaultAddress:(UIButton *)sender {
    sender.selected = !sender.selected;
    _isDefault = sender.selected;
}
- (void)showAreaPage:(NSArray *)areaArrs {
    @weakify(self);
    AreaChoseViewController *areaPage = [[AreaChoseViewController alloc]init];
    areaPage.areaArrs = areaArrs;
    
    areaPage.selectedAreaBlock = ^(ChoseAreaModel *choseArea) {
        @strongify(self);
        UITextField *tf = self.inputs[2];
        tf.text = choseArea.areaStr;
        self.choseArea = choseArea;
    };
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        areaPage.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    }else{
        areaPage.modalPresentationStyle=UIModalPresentationCurrentContext;
    }
    [self presentViewController:areaPage animated:YES completion:nil];
    
}
#pragma mark request
- (void)requestAddress {

    WeakObj(self);
    [AFNetworkTool postJSONWithUrl:get_regionlist_url parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            NSArray *region_list = responseObject[@"content"][@"region_list"];
            NSArray *areaArrs = [NSArray yy_modelArrayWithClass:[provinceModel class] json:region_list];
            [selfWeak showAreaPage:areaArrs];
        }else {
            
        }
    } fail:^{
        
    }];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArrs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != self.leftArrs.count-1) {
        AddressInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddressInfoCell class])];
        cell.leftTitel.text = self.leftArrs[indexPath.row];
        if ([self judgeEdit]) {
            if (indexPath.row == 0) {
                cell.inputField.text = self.adress.contact_name;
            }else if (indexPath.row == 1) {
                cell.inputField.text = self.adress.contact_tel;
            }else if (indexPath.row == 2) {
                cell.inputField.text = [NSString stringWithFormat:@"%@%@%@",self.adress.province_name, self.adress.city_name, self.adress.district_name];
            }else if (indexPath.row == 3) {
                cell.inputField.text = self.adress.contact_addr;
            }
        }else {
            cell.inputField.placeholder = self.placeholderArrs[indexPath.row];
        }
        if (indexPath.row == 2) {
            cell.inputField.enabled = NO;
            cell.button.hidden = NO;
            @weakify(self);
            cell.operatorAddressBlock = ^{
                @strongify(self);
                [self requestAddress];
            };
        }
        [self.inputs addObject:cell.inputField];
        return cell;
    }else {
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kMainScreenWidth , 1)];
        topLine.backgroundColor = [UIColor c_f5f5Color];
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
        [setBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [setBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        setBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [setBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [setBtn setImage:[UIImage imageNamed:@"icon_normal_01"] forState:UIControlStateNormal];
        [setBtn setImage:[UIImage imageNamed:@"icon_normal_02"] forState:UIControlStateSelected];
        [setBtn addTarget:self action:@selector(clickDefaultAddress:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:topLine];
        [cell.contentView addSubview:setBtn];
        if ([self judgeEdit] && [self.adress.defaultStatus isEqualToString:@"2"]) {
            setBtn.selected = YES;
        }
       
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self requestAddress];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark set & get
- (NSArray *)leftArrs {
    if (!_leftArrs) {
        _leftArrs = @[@"联系人", @"联系电话", @"所在区域", @"详细地址" , @"设为默认地址"];
    }
    return _leftArrs;
}
- (NSArray *)placeholderArrs {
    if (!_placeholderArrs) {
        _placeholderArrs = @[@"收货人姓名", @"收货人电话", @"选择区域", @"如街道、楼层、门牌号等", @"设为默认地址"];
    }
    return _placeholderArrs;
}

@end
