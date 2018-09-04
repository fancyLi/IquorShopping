//
//  UserVIP.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface VIPLevel : NSObject
@property (nonatomic, copy) NSString *grade_name;
@property (nonatomic, copy) NSString *grade_money;
@property (nonatomic, copy) NSString *grade_text;
@property (nonatomic, copy) NSString *level;
@end
@interface UserVIP : NSObject
@property (nonatomic, strong) NSArray <VIPLevel *>*up_grade;
@property (nonatomic, copy) NSString *interests;
@end
