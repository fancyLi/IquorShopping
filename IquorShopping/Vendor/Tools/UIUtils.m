

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Accelerate/Accelerate.h>

@implementation UIUtils

#pragma mark - 时间格式化处理
#pragma mark  date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	return str;
}

#pragma mark  string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

#pragma mark  将一种格式的日期转成另一种格式的日期
+ (NSString*) stringFromFomate:(NSString *)datestring srcFormate:(NSString*)srcFormate tarFormate:(NSString *)tarFormate
{
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:srcFormate];
    return [UIUtils stringFromFomate:createDate formate:tarFormate];
}

+ (NSString *)stringFromFomate:(NSString *)datestring 
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [formatter dateFromString:datestring];
    
    NSDate *now = [NSDate date];
    
    // 比较微博发送时间和当前时间
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    if (delta < 60) { // 1分钟以内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 60分钟以内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
        return [NSString stringWithFormat:@"%.f小时前", delta/(60 * 60)];
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
}

+ (NSString *)stringFromFomate2:(NSString *)datestring
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *date = [formatter dateFromString:datestring];
    
    NSDate *now = [NSDate date];
    
    // 比较微博发送时间和当前时间
    NSTimeInterval delta = [now timeIntervalSinceDate:date];
    
    
    if (delta < 60) { // 1分钟以内
        return @"刚刚";
    } else if (delta < 60 * 60) { // 60分钟以内
        return [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 24小时内
//        formatter.dateFormat = @"HH:mm";
//        return [formatter stringFromDate:date];
        return [NSString stringWithFormat:@"%.f小时前", delta/(60 * 60)];
    } else {
        formatter.dateFormat = @"HH:mm\nMM月dd日";
        return [formatter stringFromDate:date];
    }
}

#pragma mark当前时间的Component
+ (NSDateComponents *)dateComponents{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now = [NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    return comps;
}


#pragma mark今天
+ (NSString *)today
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* result = [formatter stringFromDate:date];
    return result;
}

#pragma 今天
+ (NSString *)todayUSA
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"MM/dd/yyyy"];

    NSString* result = [formatter stringFromDate:date];
    return result;
}

+ (NSString *)todayUSADate
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString* result = [formatter stringFromDate:date];
    return result;
}


#pragma mark明天
+ (NSString *)tomorrow
{
    NSDate* date = [NSDate date];
    date = [date dateByAddingTimeInterval:24 * 60 * 60];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* result = [formatter stringFromDate:date];
    return result;
}

#pragma mark昨天
+ (NSString *)yesterday
{
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: - (24*60*60) ];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* result = [formatter stringFromDate:yesterday];
    return result;
}

#pragma mark 明天时间戳 123423425343
+(NSString*)tomorrowLongStr
{
    NSDate* dateTo = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    NSTimeInterval a=[dateTo timeIntervalSince1970];
    long b=(long)a;
    //获取明天的时间戳
    NSString *tomorrowStr = [NSString stringWithFormat:@"%ld", b];
    return tomorrowStr;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    return [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
}

#pragma mark - 字符串处理
#pragma mark 判断字符串是否为空
+ (BOOL)isNullOrEmpty:(NSString*)string{
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    string = [NSString stringWithFormat:@"%@",string];
	return string == nil || string==(id)[NSNull null] || [string isEqualToString: @""] || string.length == 0 || [string isEqualToString:@"(null)" ] || [string isEqualToString:@"null"] |[string isEqualToString:@"<null>"];
}

+ (NSString *)emptyString:(NSString *)string
{
    if ([self isNullOrEmpty:string]) {
        return @"";
    }
    return string;
}


#pragma mark 判断手机号
+ (BOOL)checkPhoneNum:(NSString *)ihoneNum{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *regex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:ihoneNum];
}

#pragma mark 判断手机号是否为移动号码
+ (BOOL)checkPhoneNumIsTD:(NSString *)ihoneNum{
    NSString *regex = @"(((13)[4-9]{1})|((15)[0,1,2,7,8,9]{1})|((18)[2,7,8]{1}))[0-9]{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:ihoneNum];
}

#pragma mark 判断邮箱
+ (BOOL)checkEmail:(NSString *)email{
    //^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w{2,3}){1,3})$
    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:email];
}



#pragma mark - 图片处理
#pragma mark 图片压缩
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this newcontext, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark 图片拉升 ios5.0之前
+(UIImage*)imageStretchable:(UIImage*)image leftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    return [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

#pragma mark图片拉升 ios5.0之后
+(UIImage*)imageResizable:(UIImage*)image left:(NSInteger)left top:(NSInteger)top right:(NSInteger)right bottom:(NSInteger)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return [image resizableImageWithCapInsets:insets];
    
    //ios6.0
    //return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

#pragma mark - 提示框
#pragma mark alert提示框
+ (UIAlertView *)alert:(NSString*)title message:(NSString*)message{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    return alter;
}

#pragma mark 提示框
+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom
{
//    GCDiscreetNotificationView *notificationView = [[GCDiscreetNotificationView alloc] initWithText:text showActivity:isLoading inPresentationMode:isBottom?GCDiscreetNotificationViewPresentationModeBottom:GCDiscreetNotificationViewPresentationModeTop inView:view];
//    [notificationView show:YES];
//    [notificationView hideAnimatedAfter:2.6];
    
}

#pragma mark - 翻转数组
+ (NSMutableArray *)reverse:(NSMutableArray *)array length:(int)leng
{
    for(int i=0; i<leng/2; i++){
        id temp = array[i];
        array[i] = array[leng-1-i];
        array[leng-1-i] = temp;
    }
    return array;
}

#pragma mark - 隐藏键盘
+ (void)hiddenKeyBoard
{
    [UIView animateWithDuration:.35 animations:^{
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }];
//    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:Nil from:nil forEvent:nil];
    
}


#pragma mark - 颜色
//使用UIColor *textColor = [UIUtils colorWithRGBHex:0x0E74C1]
+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
+ (UIColor *)colorWithHexString:(NSString *)color{
    
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1];
}

//加毛玻璃效果，image是图片，blur是模糊度
+ (UIImage *)imageBlurry:(UIImage *)image withBlurLevel:(CGFloat)blur {
    
    //模糊度,
    
    if ((blur < 0.1f) || (blur > 2.0f)) {
        
        blur = 0.5f;
        
    }
    
    //boxSize必须大于0
    
    int boxSize = (int)(blur * 100);
    
    boxSize -= (boxSize % 2) + 1;
    
 //   NSLog(@"boxSize:%i",boxSize);
    
    //图像处理
    
    CGImageRef img = image.CGImage;
    
    //需要引入#import <Accelerate/Accelerate.h>
    
    /*
     
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     
     */
    
    
    
    //图像缓存,输入缓存，输出缓存
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    //像素缓存
    
    void *pixelBuffer;
    
    
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    
    // provider’s data.
    
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    
    
    //宽，高，字节/行，data
    
    inBuffer.width = CGImageGetWidth(img);
    
    inBuffer.height = CGImageGetHeight(img);
    
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    
    
    //像数缓存，字节行*图片高
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    
    
    outBuffer.data = pixelBuffer;
    
    outBuffer.width = CGImageGetWidth(img);
    
    outBuffer.height = CGImageGetHeight(img);
    
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    vImage_Buffer outBuffer2;
    
    outBuffer2.data = pixelBuffer2;
    
    outBuffer2.width = CGImageGetWidth(img);
    
    outBuffer2.height = CGImageGetHeight(img);
    
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
  //    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    
    
    
    if (error) {
        
        NSLog(@"error from convolution %ld", error);
        
    }
    
    
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    
    //颜色空间DeviceRGB
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             
                                             outBuffer.data,
                                             
                                             outBuffer.width,
                                             
                                             outBuffer.height,
                                             
                                             8,
                                             
                                             outBuffer.rowBytes,
                                             
                                             colorSpace,
                                             
                                             CGImageGetBitmapInfo(image.CGImage));
    
    
    
    //根据上下文，处理过的图片，重新组件
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    
    
    //clean up
    
    CGContextRelease(ctx);
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    free(pixelBuffer);
    
    free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imageRef);
    
    
    
    return returnImage;
    
}

int DeviceHight()
{
    CGRect rx = [ UIScreen mainScreen ].bounds;
    return rx.size.height;
}

int DeviceWidth(){

    CGRect rx = [UIScreen mainScreen ].bounds;
    return rx.size.width;
}

/**
 *  生成随机GUID串，全球唯一
 *
 *  @return 字符串
 */
+(NSString*)getStringWithGUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);
    NSString *uuidString =(NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    uuidString=[NSString stringWithUTF8String:[uuidString cStringUsingEncoding:NSUTF8StringEncoding]];
    CFRelease(uuidObj);
    uuidString= [uuidString lowercaseString];
    return uuidString;
}

/**
 *自适应宽度
 */
- (float)getLBWidForString:(NSString *)aString  heightForLabel:(float)height  fontForLabel:(float)font{
    if ([UIUtils isNullOrEmpty:aString])
    {
        return 0;
    }
    else
    {
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:font]};
        CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil];
        return rect.size.width;
    }
}


/**
 *自适应高度
 */
- (float)getLBHeightForString:(NSString *)strVar widthForLabel:(float)width fontForLabel:(float)fontNum{
    if ([UIUtils isNullOrEmpty:strVar])
    {
        return 0;
    }
    else
    {
        UIFont *font = [UIFont systemFontOfSize:fontNum];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]
         initWithString:strVar
         attributes:@
         {
         NSFontAttributeName: font
         }];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        return rect.size.height;
    }
}

@end
