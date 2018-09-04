//
//  PDDDataManger.m
//  PDDScalping
//
//  Created by 储强盛 on 2017/7/12.
//  Copyright © 2017年 yytz. All rights reserved.
//

#import "PDDDataManger.h"

@implementation PDDDataManger

+ (PDDDataManger*)sharedInstance {
    static PDDDataManger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PDDDataManger alloc] init];
    });
    return sharedInstance;
    
}

+(void)saveLoginCookie {
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    if ([NSKeyedArchiver archiveRootObject:cookies toFile:CookieStoragePath]) {
        NSLog(@"archive cookies success! - %@",cookies);
    }
}

+(void)cleanLoginCookie {
   
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (int i = 0; i < [cookies count]; i++) {
        NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    //重新保存 被清空的 cookie
    [PDDDataManger saveLoginCookie];
}

+(void)loadLoginCookie {
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithFile:CookieStoragePath];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookies){
        [cookieStorage setCookie: cookie];
    }
    
    NSLog(@"加载 cookie  -- %@",cookies);
}
@end
