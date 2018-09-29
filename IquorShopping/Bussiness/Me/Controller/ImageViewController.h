//
//  ImageViewController.h
//  IquorShopping
//
//  Created by nanli5 on 2018/6/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImageChoosed) (UIImage *image);
@interface ImageViewController : NSObject
@property (nonatomic, copy) ImageChoosed imageChooseBlock;

- (void)choosePhotoOrCamera;
+ (instancetype)shareImageVC;
@end
