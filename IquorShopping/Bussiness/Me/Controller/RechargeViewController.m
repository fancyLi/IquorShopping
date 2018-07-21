//
//  RechargeViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/19.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "RechargeViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import "WechatOrder.h"
@interface RechargeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfied;

@property (weak, nonatomic) IBOutlet UIImageView *baoIcon;
@property (weak, nonatomic) IBOutlet UIImageView *chatIcon;
@property (weak, nonatomic) IBOutlet UIView *chatView;
@property (weak, nonatomic) IBOutlet UIView *baoView;
@property (nonatomic, copy) NSString *pay_type;
@property (nonatomic, strong) WechatOrder *weChatOrder;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(baoClick)];
    [self.baoView addGestureRecognizer:tapGes];
    
    UITapGestureRecognizer *tapGes2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weChatClick)];
    [self.chatView addGestureRecognizer:tapGes2];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)baoClick {
    self.baoIcon.image = [UIImage imageNamed:@"icon_normal_02"];
    self.chatIcon.image = [UIImage imageNamed:@"icon_normal_01"];
    self.pay_type = @"1";
}
- (void)weChatClick {
    self.baoIcon.image = [UIImage imageNamed:@"icon_normal_01"];
    self.chatIcon.image = [UIImage imageNamed:@"icon_normal_02"];
    self.pay_type = @"2";
}
- (IBAction)buttonClick:(id)sender {
    if ([UIUtils isNullOrEmpty:self.pay_type]) {
        [Dialog popTextAnimation:@"请选择充值方式"];
    }else if ([UIUtils isNullOrEmpty:self.textfied.text]) {
        [Dialog popTextAnimation:@"请输入充值金额"];
    }else {
        [Dialog showSVPWithStatus:@"正在处理..."];
        NSDictionary *param = @{@"pay_type":self.pay_type, @"pay_scene":@"1", @"recharge_money":self.textfied.text};
        @weakify(self);
        [AFNetworkTool postJSONWithUrl:pay_requestPayment parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                if (self.pay_type.integerValue == 1) {
                    [self doAPPay:responseObject[@"content"]];
                }else {
                    [self doWeChat:[WechatOrder yy_modelWithDictionary:responseObject[@"content"]]];
                }
            }else {
                [Dialog popTextAnimation:responseObject[@"message"]];
            }
        } fail:^{
            
        }];
    }
}

- (void)doAPPay:(NSString *)orderString {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"com.elevation.IquorShopping" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}
- (void)doWeChat:(WechatOrder *)order {
    PayReq *request = [[PayReq alloc] init];
    
    request.partnerId = order.partnerid;
    
    request.prepayId= order.prepayid;
    
    request.package = order.package;
    
    request.nonceStr= order.noncestr;
    
    request.timeStamp= order.timestamp;
    
    request.sign= order.sign;
    [WXApi sendReq:request];
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
