//
//  VIPLevelViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "VIPLevelViewController.h"
#import "VIPLevelCell.h"
#import "UserVIP.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import "WechatOrder.h"
#import "PayKindViewController.h"
@interface VIPLevelViewController ()<UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *viplevel;
@property (weak, nonatomic) IBOutlet UILabel *vipPrice;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UserVIP *vip;
@property (nonatomic, copy) NSString *curLevel;
@end

@implementation VIPLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成为会员";
    [self requestVipLevel];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.tableview.rowHeight = 80;
    self.tableview.estimatedSectionFooterHeight = 5;
    self.tableview.estimatedSectionHeaderHeight = 5;
    self.tableview.showsHorizontalScrollIndicator = NO;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"VIPLevelCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([VIPLevelCell class])];
    // Do any additional setup after loading the view from its nib.
}
- (void)requestVipLevel {
    @weakify(self);
    [AFNetworkTool postJSONWithUrl:user_upGrade parameters:nil success:^(id responseObject) {
        @strongify(self);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            self.vip = [UserVIP yy_modelWithDictionary:responseObject[@"content"]];
            [self.webview loadHTMLString:self.vip.interests baseURL:nil];
            [self.tableview reloadData];
        }else {
            
        }
    } fail:^{
        
    }];
}
- (IBAction)buttonClick:(id)sender {
    if ([UIUtils isNullOrEmpty:self.curLevel]) {
        [Dialog popTextAnimation:@"请选择会员等级"];
    }else {
        PayKindViewController *vc = [[PayKindViewController alloc]init];
        vc.pay_scene = @"3";
        @weakify(self);
        vc.operatorPayCellBlock = ^(OrderPay *pay) {
            @strongify(self);
            [self startOrder:pay.pay_type];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)startOrder:(NSString *)type {
    if ([UIUtils isNullOrEmpty:self.curLevel]) {
        [Dialog popTextAnimation:@"请选择会员等级"];
    }else {
        NSDictionary *param = @{@"pay_type":type, @"pay_scene":@"3", @"level":self.curLevel};
        @weakify(self);
        [AFNetworkTool postJSONWithUrl:pay_requestPayment parameters:param success:^(id responseObject) {
            @strongify(self);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                if (type.integerValue == 1) {
                    [self doAPPay:responseObject[@"content"]];
                }else if (type.integerValue == 2) {
                    [self doWeChat:[WechatOrder yy_modelWithDictionary:responseObject[@"content"]]];
                }else {
                    [Dialog popTextAnimation:@"支付成功"];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.vip.up_grade.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VIPLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VIPLevelCell class])];
    cell.layer.cornerRadius = 5;
    cell.vip = self.vip.up_grade[indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    VIPLevelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor c_f5f5Color];
    cell.layer.borderColor = [UIColor c_f5f5Color].CGColor;
    cell.layer.borderWidth = 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VIPLevelCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColorFromRGB(0xFFF1C8);
    cell.layer.borderColor = UIColorFromRGB(0xCF9E65).CGColor;
    cell.layer.borderWidth = 1;
    self.vipPrice.text = [NSString stringWithFormat:@"￥%@",self.vip.up_grade[indexPath.section].grade_money];
    self.viplevel.text = self.vip.up_grade[indexPath.section].grade_name;
    self.curLevel = self.vip.up_grade[indexPath.section].level;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableview.frame), webViewHeight);
    [self.tableview beginUpdates];
    [self.tableview setTableHeaderView:webView];
    [self.tableview endUpdates];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableview.frame), 40)];
        _webview.delegate = self;
    }
    return _webview;
}

@end
