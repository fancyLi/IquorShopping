//
//  IquorUser.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/1.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IquorUser : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *user_tel;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *user_code;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *level_name;
@property (nonatomic, copy) NSString *service_number;

+ (instancetype)shareIquorUser;

- (void)configDict:(NSDictionary *)dict;
@end
