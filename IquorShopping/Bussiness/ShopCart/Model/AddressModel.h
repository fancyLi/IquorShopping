//
//  AddressModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/8.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *contact_addr;
@property (nonatomic, copy) NSString *contact_name;
@property (nonatomic, copy) NSString *contact_tel;
@property (nonatomic, copy) NSString *defaultStatus;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *district_name;
@property (nonatomic, copy) NSString * isdel;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *uid;
@end
