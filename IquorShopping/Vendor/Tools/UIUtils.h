//
//  UIUtils.h


#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

#pragma mark - 时间格式化处理
//date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;
//string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;
+ (NSString *)fomateString:(NSString *)datestring;
//将一种格式的日期转成另一种格式的日期
+ (NSString*) stringFromFomate:(NSString *)date srcFormate:(NSString*)srcFormate tarFormate:(NSString *)tarFormate;
+ (NSString *)stringFromFomate:(NSString *)datestring;
+ (NSString *)stringFromFomate2:(NSString *)datestring;
//当前时间的Component
+ (NSDateComponents *)dateComponents;

//今天 明天 昨天
+ (NSString *)today;

//今天不带 星期
+(NSString*)todayUSADate;

//今天，美国格式
+ (NSString *)todayUSA;
+ (NSString *)tomorrow;
+ (NSString *)yesterday;

//获取明天的时间戳  长整形
+(NSString*)tomorrowLongStr;

#pragma mark - 字符串处理
//判断字符串是否为空
+ (BOOL)isNullOrEmpty:(NSString*)string;
+ (NSString *)emptyString:(NSString *)string;
//判断手机号
+ (BOOL)checkPhoneNum:(NSString *)ihoneNum;
// 判断手机号是否为移动号码
+ (BOOL)checkPhoneNumIsTD:(NSString *)ihoneNum;
//判断邮箱
+ (BOOL)checkEmail:(NSString *)email;



#pragma mark - 图片处理
//图片压缩
+(UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
//图片拉升 ios5.0之前
+(UIImage*)imageStretchable:(UIImage*)image leftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

//图片拉升 ios5.0之后
+(UIImage*)imageResizable:(UIImage*)image left:(NSInteger)left top:(NSInteger)top right:(NSInteger)right bottom:(NSInteger)bottom;

#pragma mark - 提示框

//ios上下提示框 需要倒入GCDiscreetNotificationView工具类
+ (void)ToastNotification:(NSString *)text andView:(UIView *)view andLoading:(BOOL)isLoading andIsBottom:(BOOL)isBottom;

#pragma mark - 翻转数组
+(NSMutableArray *)reverse:(NSMutableArray *)array length:(int)leng;

#pragma mark - 隐藏键盘
//隐藏键盘
+ (void)hiddenKeyBoard;

#pragma mark 网络是否连接上
+ (BOOL)isNetworkEnabled;

/**
 *  生成随机GUID串，全球唯一
 *
 *  @return 字符串
 */
+(NSString*)getStringWithGUID;

int DeviceHight();

int DeviceWidth();


/**
 *自适应宽度
 */
- (float)getLBWidForString:(NSString *)aString  heightForLabel:(float)height  fontForLabel:(float)font;


/**
 *自适应高度
 */
- (float)getLBHeightForString:(NSString *)strVar widthForLabel:(float)width fontForLabel:(float)fontNum;

#pragma mark - 颜色
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

+ (UIColor *)colorWithHexString:(NSString *)color;
/**
 *加模糊效果，image是图片，blur是模糊度
 */
+ (UIImage *)imageBlurry:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
