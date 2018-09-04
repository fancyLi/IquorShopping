//
//  AreaChoseViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/6.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"
@class ChoseAreaModel;
typedef void (^SelectedArea)(ChoseAreaModel *choseArea);

@interface AreaChoseViewController : IquorViewController
@property (nonatomic, strong) NSArray *areaArrs;
@property (nonatomic, copy) SelectedArea selectedAreaBlock;
@end
