//
//  CityModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/6.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AreaModel;

@interface CityModel : NSObject
@property (nonatomic, copy) NSString *region_id;
@property (nonatomic, copy) NSString *region_name;
@property (nonatomic, strong) NSArray<AreaModel *> *sub;
@end


@interface provinceModel : NSObject
@property (nonatomic, copy) NSString *region_id;
@property (nonatomic, copy) NSString *region_name;
@property (nonatomic, strong) NSArray<CityModel *> *sub;
@end
