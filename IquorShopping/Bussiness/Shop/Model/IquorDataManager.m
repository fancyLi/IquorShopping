//
//  IquorDataManager.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorDataManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApi.h>
#import "WechatOrder.h"
#import "endOrderViewController.h"
typedef void (^Complation)(BOOL isScu);
@interface IquorDataManager ()
@property (nonatomic, strong) IquorRequestModel *requestModel;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy) NSString *scene;
@property (nonatomic, copy) Complation complation;
@end
@implementation IquorDataManager

//singtonImplement(IquorDataManager)

static IquorDataManager *manager = nil;
+ (instancetype)shareInstance {
    manager = [[IquorDataManager alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(intoEndOrder:) name:@"orderresult" object:nil];
    return manager;
}
- (void)submitOrderParameters:(NSDictionary *)param payKind:(NSString *)kind enterVC:(BOOL)enable orderCom:(void (^)(BOOL))complation {
    self.scene = [param objectForKey:@"pay_scene"];
    self.enable = enable;
    self.complation = complation;
    [AFNetworkTool postJSONWithUrl:pay_requestPayment parameters:param success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            if (kind.intValue == 3) {
                if (enable) {
                    endOrderViewController *vc = [[endOrderViewController alloc]init];
                    vc.endOrder = [OrderResult yy_modelWithDictionary:responseObject[@"content"]];
                    [IquorDataManager.getCurrentVC.navigationController pushViewController:vc animated:YES];
                    
                }else {
                    [Dialog popTextAnimation:@"支付成功"];
                }
                complation(YES);
            }else if (kind.intValue == 2) {
                [manager startWechatOrder:responseObject[@"content"]];
            }else if (kind.intValue == 1) {
                [manager startBaoOrder:responseObject[@"content"]];
            }
            
        }else {
            [Dialog popTextAnimation:responseObject[@"message"]];
        }
        
    } fail:^{
        
    }];
    
}

- (void)updateUserInfo:(void (^)(BOOL))complation {
    [AFNetworkTool postJSONWithUrl:get_user_info_url parameters:nil success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 200) {
            [IQourUser yy_modelWithDictionary:responseObject[@"content"]];
            [[IQourUser shareInstance] save];
            complation(YES);
        }else {
            complation(NO);
        }
    } fail:^{
        complation(NO);
    }];
}


#pragma mark -private
- (void)intoEndOrder:(NSNotification *)noti {
    if (_enable) {
        NSDictionary *param = @{@"order_sn":self.code};
        [AFNetworkTool postJSONWithUrl:order_getOrdersnInfo parameters:param success:^(id responseObject) {
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 200) {
                endOrderViewController *vc = [[endOrderViewController alloc]init];
                vc.endOrder = [OrderResult yy_modelWithDictionary:responseObject[@"content"]];
                [IquorDataManager.getCurrentVC.navigationController pushViewController:vc animated:YES];
            }else {
                manager.complation(YES);
            }
        } fail:^{
            
        }];
    }else {
        manager.complation(YES);
    }
    
    
}
- (void)startBaoOrder:(id)content {
    NSString *orderString;
    if (manager.scene.intValue == 2 || manager.scene.intValue == 3) {
        orderString = content;
    }else {
        orderString = [content objectForKey:@"result"];
        manager.code = content[@"order_sn"];
    }
    
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"com.elevation.IquorShopping" callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
    }];
}

- (void)startWechatOrder:(id)orderDict {
    WechatOrder *order;
    if (manager.scene.intValue == 2 || self.scene.intValue == 3) {
        order = [WechatOrder yy_modelWithDictionary:orderDict];
    }else {
        order = [WechatOrder yy_modelWithDictionary:orderDict[@"result"]];
        manager.code = orderDict[@"order_sn"];
    }
    
    
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = order.partnerid;
    
    request.prepayId= order.prepayid;
    
    request.package = order.package;
    
    request.nonceStr= order.noncestr;
    
    request.timeStamp= order.timestamp;
    
    request.sign= order.sign;
    [WXApi sendReq:request];
    

    
  
}
@end
