//
//  NSObject+Util.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "NSObject+Util.h"

@implementation NSObject (Util)
+ (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}
- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

+ (NSString *)getTimeYYMMDDHHMM {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateStr;
}
+ (NSString *)getTimeYYMMDDHHMMFromTimeString:(NSString *)timeString {
    if ([timeString isEqualToString:@""] || timeString == nil) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [dateFormatter2 stringFromDate:date];
    return dateStr;
}
+ (NSString *)getTimeYYMMDDHHMMFromNYR:(NSString *)timeString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [dateFormatter2 stringFromDate:date];
    return dateStr;
}

+ (NSString *)encodeURL:(NSString *)string {
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    ;
    if ([newString containsString:@"%5C"]) {
        newString = [newString stringByReplacingOccurrencesOfString:@"%5C" withString:@"\\"];
    }
    if (newString) {
        return newString;
    }
    return @"";
}
+ (NSString*)encodeURL1:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    ;
    
    if (newString) {
        return newString;
    }
    return @"";
}

+ (NSString *)base64Encoded:(NSString *)string {
    NSData *utf8EncodeData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64EncodedString = [utf8EncodeData base64EncodedStringWithOptions:0];
    return base64EncodedString;
    
}
+ (UIImage *)base64StrToUIImage:(NSString *)string {
    NSData  *decodedImageData   = [[NSData alloc]initWithBase64EncodedString:string options:0];
    UIImage *decodedImage       = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}


@end
