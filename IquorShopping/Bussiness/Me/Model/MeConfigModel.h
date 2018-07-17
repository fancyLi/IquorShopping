//
//  MeConfigModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/14.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeConfigModel : NSObject
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *dec;
@property (nonatomic, copy) NSString *className;

@property (nonatomic, strong) NSArray *configModels;

- (instancetype)initIconName:(NSString *)ic dec:(NSString *)dec cla:(NSString *)cla;

@end
