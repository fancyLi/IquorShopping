//
//  IquorButton.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "IquorButton.h"

@implementation IquorButton

// 重写下面两个方法，返回正确的布局即可。

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (!CGRectIsEmpty(self.titleRect) &&
        !CGRectEqualToRect(self.titleRect, CGRectZero))
    {
        return self.titleRect;
    }
    
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (!CGRectIsEmpty(self.imageRect) &&
        !CGRectEqualToRect(self.imageRect, CGRectZero))
    {
        return self.imageRect;
    }
    
    return [super imageRectForContentRect:contentRect];
}

@end
