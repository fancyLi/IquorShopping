//
//  endOrderViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/16.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "endOrderViewController.h"
#import "IndentViewController.h"
@interface endOrderViewController ()
{
    BOOL isSuc;
}
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UILabel *bus_contact;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameCon;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end

@implementation endOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款结果";
    self.leftBtn.layer.cornerRadius = 5;
    self.leftBtn.layer.borderWidth = 1;
    self.leftBtn.layer.borderColor = [UIColor c_e8e8Color].CGColor;
    
    self.rightBtn.layer.cornerRadius = 5;
    self.rightBtn.layer.borderWidth = 1;
    self.rightBtn.layer.borderColor = [UIColor c_e8e8Color].CGColor;
    if (self.endOrder) {
        self.nameCon.text = [NSString stringWithFormat:@"%@  %@", self.endOrder.return_addr.contact_name, self.endOrder.return_addr.contact_tel];
        self.adress.text = [NSString stringWithFormat:@"%@%@%@%@", self.endOrder.return_addr.province_name, self.endOrder.return_addr.city_name, self.endOrder.return_addr.district_name, self.endOrder.return_addr.contact_addr];
        self.price.text = [NSString stringWithFormat:@"实付：￥%@", self.endOrder.order_total];
        if (self.endOrder) {
            self.icon.image = [UIImage imageNamed:@"icon_prompt_01"];
            self.result.text = @"付款成功";
            self.result.textColor = UIColorFromRGB(0x0db530);
            self.bus_contact.text = [NSString stringWithFormat:@"我们会尽快安排发货\n如有疑问请联系：%@", self.endOrder.service_number];
            [self.leftBtn setTitle:@"查看订单" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"继续购物" forState:UIControlStateNormal];
            isSuc = YES;
        }else {
            self.icon.image = [UIImage imageNamed:@"icon_prompt_02"];
            self.result.text = @"付款失败";
            self.result.textColor = [UIColor c_cc0Color];
            self.bus_contact.text = [NSString stringWithFormat:@"请完成付款\n否则订单会被系统取消"];
            [self.leftBtn setTitle:@"查看订单" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"重新付款" forState:UIControlStateNormal];
        }
    }
    
}

- (IBAction)leftClick:(id)sender {
    IndentViewController *vc = [[IndentViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)rightClick:(id)sender {
    if (isSuc) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
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
