

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "Dialog.h"

@interface Dialog : NSObject


/**
 提示消息
 */
+ (void)showMessage:(NSString *)msg;

/**
 *  加载数据状态
 *  @param status   文字描述
 */
+ (void)showSVPWithStatus:(NSString*)status;

//+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
/**
 *  感叹号
 */
+ (void)showInfoWithStatus:(NSString*)status;
/**
 *  success
 */
+ (void)showSuccessWithStatus:(NSString*)status;
/**
 *  error
 */
+ (void)showErrorWithStatus:(NSString*)status;

+ (void)hideSVProgressHUD;
+(void)showWithMaskType:(SVProgressHUDMaskType)maskType;
+ (Dialog *)Instance;


#pragma mark alert提示框
+ (UIAlertView *)alertTitle:(NSString*)title message:(NSString*)message;


//+ (void)simpleToast:(NSString *)message;
+ (void)hideSimpleToast;
//显示在屏幕中间
+ (void)toastCenter:(NSString *)message withDuration:(NSTimeInterval)duration;

//弹出多行动画文字，动画
+(void)popTextAnimation:(NSString *)popText;

#pragma mark - FVC网络加载多种提示框
///**
// *等待框
// */
//+(void)showFVCLoading;
//
///**
// *等待框,文字
// */
//+(void)showFVCLoadingWithTitle:(NSString*)title;
//
///**
// *正确提示框
// */
//+(void)showFVCDone;
//
//
///**
// *错误提示框
// */
//+(void)showFVCError;
//
//
///**
// *警告提示框
// */
//+(void)showFVCAlert;
//
///**
// *关闭提示框
// */
//+(void)closeFVC;
//
//



@end
