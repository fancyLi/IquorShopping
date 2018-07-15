//
//  AdressListViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"
#import "AddressModel.h"
typedef void (^OpretorAddressBlock)(AddressModel *model);
@interface AdressListViewController : IquorViewController
@property (nonatomic, copy) OpretorAddressBlock opretorAddressBlock;
@end
