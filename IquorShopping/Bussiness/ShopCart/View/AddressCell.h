//
//  AddressCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/5.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AddressOperate) {
    KDeleteCurrent = 0,
    KEditCurrent
};

typedef void (^OperateAddressBlock)(AddressOperate operate);

@class AddressModel;
@interface AddressCell : UITableViewCell
@property (nonatomic, copy) OperateAddressBlock operateAddressBlock;
- (void)configModel:(AddressModel *)model;

@end
