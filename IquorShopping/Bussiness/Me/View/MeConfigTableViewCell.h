//
//  MeConfigTableViewCell.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/10.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeConfigModel;

@protocol MeConfigTableViewCellDelegate <NSObject>
- (void)selectedConfigModel:(MeConfigModel *)cm;
@end
@interface MeConfigTableViewCell : UITableViewCell
@property (nonatomic, assign) id<MeConfigTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSArray<MeConfigModel *> *cellModel;

@end
