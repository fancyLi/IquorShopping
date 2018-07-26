//
//  IquorDataManager.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/25.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IquorRequestModel.h"

@interface IquorDataManager : NSObject
//singtonInterface

+ (instancetype)shareInstance;

- (void)submitOrderParameters:(NSDictionary *)param payKind:(NSString *)kind enterVC:(BOOL)enable orderCom:(void (^)(BOOL isScu))complation;

- (void)updateUserInfo:(void(^)(BOOL isScu))complation;

@end
