//
//  CommonHeader.h
//  LocationSign
//
//  Created by 储强盛 on 2016/11/26.
//  Copyright © 2016年 yytz. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h
#define DBName  @"DataBase.db"                    //数据库名称

//cookies对象存储地址
#define CookieStoragePath   [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0] stringByAppendingPathComponent:@"cookies.archive"]

//友盟
#define UMengAppkey        @"593d260a8f4a9d03b40016e0"


#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj;

#define UersLocationSign        [NSUserDefaults standardUserDefaults]

#define kMainScreenFrameRect   [[UIScreen mainScreen] bounds]

//设备屏幕宽
#define kMainScreenWidth  kMainScreenFrameRect.size.width

//设备屏幕高度
#define kMainScreenHeight kMainScreenFrameRect.size.height

// 获取状态栏高度, iPhone X不是20了
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
// iPhone X安全区的原因，UITabBar 高度由49pt变成了83pt，
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBottom ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

#define ImageWithName(name)\
[UIImage imageNamed:name]
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

                                                          \

#define COLOR_BG        UIColorFromRGB(0xf6f6f6)//背景灰

#define COLOR_LINECELL  UIColorFromRGB(0xe8e8e8) //系统cell 线条颜色
#define COLOR_PlaceHolder    UIColorFromRGB(0xcccccc)//输入框文字颜色
#define COLOR_PLACEGRAY    UIColorFromRGB(0xcccccc)//浅灰

/********** PDD 项目定义色值***************/
#define COLOR_THEME     UIColorFromRGB(0x4C8BFE)//主题蓝色
#define COLOR_Content      UIColorFromRGB(0x333333)//黑色
#define COLOR_Gray      UIColorFromRGB(0x999999)//黑色
#define COLOR_LineGray       UIColorFromRGB(0xe8e8e8)//线条颜色
#define COLOR_Yellow     UIColorFromRGB(0xFC8E0D)//黄色
#define COLOR_Red    UIColorFromRGB(0xF13740)//红色

/*
 *单利
 */
#define singtonInterface  + (instancetype)shareInstance;

#define singtonImplement(class) \
\
static class *_shareInstance; \
\
+ (instancetype)shareInstance { \
\
if(_shareInstance == nil) {\
_shareInstance = [[class alloc] init]; \
} \
return _shareInstance; \
} \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone { \
\
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_shareInstance = [super allocWithZone:zone]; \
}); \
\
return _shareInstance; \
\
}

/**
 弱引用
 @param weakSelf
 @return
 */
#define IFlyWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

#endif /* CommonHeader_h */
