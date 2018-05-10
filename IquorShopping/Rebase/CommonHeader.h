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



#define WeakObj(obj) __weak typeof(obj) obj##Weak = obj;

#define UersLocationSign        [NSUserDefaults standardUserDefaults]

#define kMainScreenFrameRect   [[UIScreen mainScreen] bounds]

//设备屏幕宽
#define kMainScreenWidth  kMainScreenFrameRect.size.width

//设备屏幕高度
#define kMainScreenHeight kMainScreenFrameRect.size.height

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
#endif /* CommonHeader_h */
