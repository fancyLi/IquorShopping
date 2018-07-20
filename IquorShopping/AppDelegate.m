//
//  AppDelegate.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "AppDelegate.h"
#import "IquorTabBarViewController.h"
#import <WechatOpenSDK/WXApi.h>
#import <AlipaySDK/AlipaySDK.h>

static NSString *const wxID = @"wx86dc5e8dc01486ec";
static NSString *const appSecret = @"f21r5t4r4r512a3werq3485940x3da2a";
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:wxID];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
   
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[IquorTabBarViewController alloc]init];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [Dialog popTextAnimation:@"无网络连接"];
        }
    }];
    [[LoginOperator shareInstance] ensconceLogin];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([[resultDic valueForKey:@"resultStatus"] intValue] == 9000) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderresult" object:nil];
            }else {
                [Dialog popTextAnimation:@"支付宝付款失败"];
            }
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate-
- (void)onReq:(BaseReq *)req {
    
}
- (void)onResp:(BaseResp *)resp {

    if (resp.errCode == 0) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"orderresult" object:nil];
    }else if (resp.errCode == -2) {
        //取消授权
        [Dialog popTextAnimation:@"已取消微信支付"];
    }else {
        [Dialog popTextAnimation:@"支付失败"];
    }
}

@end
