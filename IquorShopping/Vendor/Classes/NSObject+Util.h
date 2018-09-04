//
//  NSObject+Util.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/24.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Util)

+ (UIViewController *)getCurrentVC;
+ (NSString *)getTimeYYMMDDHHMM;

+ (NSString *)getTimeYYMMDDHHMMFromTimeString:(NSString *)timeString;

+ (NSString *)getTimeYYMMDDHHMMFromNYR:(NSString *)timeString;

//转换字符串中的特殊字符
+ (NSString *)encodeURL:(NSString *)string;
+ (NSString *)encodeURL1:(NSString *)string;
+ (NSString *)base64Encoded:(NSString *)string;
+ (UIImage *)base64StrToUIImage:(NSString *)string;

@end
