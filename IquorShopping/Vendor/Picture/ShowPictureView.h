//
//  ShowPictureView.h
//  zhihuiyanglao
//
//  Created by admin on 2018/1/23.
//  Copyright © 2018年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShowPictureView;
@protocol ShowPictureViewDelegate <NSObject>
@optional
- (void)showPicClick:(ShowPictureView *)ShowPictureView clickedPicTag:(int)tag;
- (void)addButtonClick:(ShowPictureView *)ShowPictureView;
@end

@interface ShowPictureView : UIView
@property (nonatomic, weak) id<ShowPictureViewDelegate> delegate;

@property (nonatomic, assign) BOOL isNeedAddBtn;
@property (nonatomic, assign) int MaxNum;       //传入最大的照片数量，默认5张

@property (nonatomic, assign) BOOL isURL;
@property (nonatomic, strong) NSArray *picArray;
@end
