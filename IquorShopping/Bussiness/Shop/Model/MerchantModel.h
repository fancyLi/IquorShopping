//
//  MerchantModel.h
//  IquorShopping
//
//  Created by nanli on 2018/10/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject

@property (nonatomic, copy) NSString *shop_id;
@property (nonatomic, copy) NSString *shop_name;
@property (nonatomic, copy) NSString *shop_image;
@property (nonatomic, copy) NSString *shop_addr;

@end


@interface MerchantInfo : MerchantModel

@property (nonatomic, strong) NSArray *shop_pics;

@end
