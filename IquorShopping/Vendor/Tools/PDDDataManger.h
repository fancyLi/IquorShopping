//
//  PDDDataManger.h
//  PDDScalping
//
//  Created by 储强盛 on 2017/7/12.
//  Copyright © 2017年 yytz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  BaseConfigModel;
//数据管理
@interface PDDDataManger : NSObject

+ (PDDDataManger*)sharedInstance ;

+(void)saveLoginCookie;
+(void)cleanLoginCookie;
+(void)loadLoginCookie;
@property(strong,nonatomic)BaseConfigModel *configModel;
@end
