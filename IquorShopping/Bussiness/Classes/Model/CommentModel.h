//
//  CommentModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nike_name;
@property (nonatomic, strong) NSArray *images;
@end
