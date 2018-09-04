//
//  MeCommentModel.h
//  IquorShopping
//
//  Created by nanli5 on 2018/7/9.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeCommentModel : NSObject
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *goods_image;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_price;
@property (nonatomic, copy) NSString *comment_id;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick_name;

@end
