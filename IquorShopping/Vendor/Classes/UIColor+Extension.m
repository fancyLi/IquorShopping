//
//  UIColor+Extension.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "UIColor+Extension.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (Extension)

+ (UIColor *)c_000color {
    return UIColorFromRGB(0x000000);
}

+ (UIColor *)c_cccColor {
    return UIColorFromRGB(0xcccccc);
}

+ (UIColor *)c_999Color {
   return UIColorFromRGB(0x999999);
}
+ (UIColor *)c_666Color {
    return UIColorFromRGB(0x999999);
}

+ (UIColor *)c_f1f1Color {
    return UIColorFromRGB(0xf1f1f1);
}

+ (UIColor *)c_f5f5Color {
    return UIColorFromRGB(0xf5f5f5);
}

+ (UIColor *)c_fafaColor {
    return UIColorFromRGB(0xfafafa);
}

+ (UIColor *)c_7878Color {
    return UIColorFromRGB(0x787878);
}

+ (UIColor *)c_cc0Color {
   return UIColorFromRGB(0xcc0210);
}

+ (UIColor *)c_333Color {
    return UIColorFromRGB(0x333333);
}

+ (UIColor *)c_fb8a35Color {
    return UIColorFromRGB(0xFB8A35);
}

+ (UIColor *)c_f6f6Color {
    return UIColorFromRGB(0xf6f6f6);
}

+ (UIColor *)c_ff8a00Color {
    return UIColorFromRGB(0xff8a00);
}

+ (UIColor *)c_e8e8Color {
    return UIColorFromRGB(0xe8e8e8);
}

+ (UIColor *)c_fbfbfbColor {
    return UIColorFromRGB(0xFBFBFB);
}

+ (UIColor *)c_f5f5f5Color {
    return UIColorFromRGB(0xF5F5F5);
}

+ (UIColor *)c_fa7231Color {
    return UIColorFromRGB(0xFA7231);
}
@end
