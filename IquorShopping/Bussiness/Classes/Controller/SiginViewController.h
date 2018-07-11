//
//  SiginViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorViewController.h"

@interface SiginViewController : IquorViewController

//分类ID
@property (nonatomic, copy) NSString *cat_id;
//分类名称
@property (nonatomic, copy) NSString *cat_name;
//搜索keywords
@property (nonatomic, copy) NSString *serContent;

@property (nonatomic, copy) NSString *type;
@end
