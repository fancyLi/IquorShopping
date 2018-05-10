
#import "Dialog.h"
#import <unistd.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "LPPopup.h"
#import "SVProgressHUD.h"
@implementation Dialog

static Dialog *instance = nil;

+ (Dialog *)Instance
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [self new];
        }
    }
    return instance;
}

+ (void)showMessage:(NSString *)msg {
    static MBProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    });
    hud.labelText = msg;
    [hud hide:YES afterDelay:2];
}
/**
 *  加载数据状态
 *  @param status   文字描述
 */
+ (void)showSVPWithStatus:(NSString*)status
{
    [SVProgressHUD showWithStatus:status];
}

/**
 *  感叹号
 */
+ (void)showInfoWithStatus:(NSString*)status
{
     [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD showInfoWithStatus:status];
}

/**
 *  success
 */
+ (void)showSuccessWithStatus:(NSString*)status
{
     [SVProgressHUD setMinimumDismissTimeInterval:2.0];
   [SVProgressHUD showSuccessWithStatus:status];
}

/**
 *  error
 */
+ (void)showErrorWithStatus:(NSString*)status
{
     [SVProgressHUD setMinimumDismissTimeInterval:2.0];
    [SVProgressHUD showErrorWithStatus:status];;
}

/**
 *  消失加载
 */
+ (void)hideSVProgressHUD
{
    [SVProgressHUD dismiss];
}
/**
 *  简单提示
 *
 *  @param maskType 显示类型
 */
+(void)showWithMaskType:(SVProgressHUDMaskType)maskType{
    [SVProgressHUD showWithMaskType:maskType];
}

+ (UIAlertView *)alertTitle:(NSString*)title message:(NSString*)message{
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
    return alter;
}



+ (void)hideSimpleToast
{
    [SVProgressHUD dismiss];
}

+ (void)toastCenter:(NSString *)message withDuration:(NSTimeInterval)duration{
    [SVProgressHUD showWithStatus:message maskType:SVProgressHUDMaskTypeGradient];
}


#pragma mark---弹出多行提示
+(void)popTextAnimation:(NSString *)popText{
    [[LPPopup appearance] setPopupColor:[UIColor blackColor]];
    LPPopup *popup = [LPPopup popupWithText:popText];

    
    UIWindow* window=[UIApplication sharedApplication].delegate.window;
    [popup showInView:window
        centerAtPoint:window.center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
}
//
//
//
//#pragma mark - FVC多种提示框
//+(void)showFVCLoading{
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [FVCustomAlertView showDefaultLoadingAlertOnView:window withTitle:@"新安为您加载..."];
//}
//
//+(void)showFVCLoadingWithTitle:(NSString*)title{
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [FVCustomAlertView showDefaultLoadingAlertOnView:window withTitle:title];
//}
//
////正确提示框
//+(void)showFVCDone{
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [FVCustomAlertView showDefaultDoneAlertOnView:window withTitle:@"Done"];
//}
////错误提示框
//+(void)showFVCError{
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [FVCustomAlertView showDefaultErrorAlertOnView:window withTitle:@"Error"];
//}
////警告提示框
//+(void)showFVCAlert{
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [FVCustomAlertView showDefaultWarningAlertOnView:window withTitle:@"Be careful"];
//}
////关闭提示框
//+(void)closeFVC{
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    [FVCustomAlertView hideAlertFromView:window fading:YES];
//    
//}
//
//
//
//+ (UIViewController *)getCurrentVC
//{
//    UIViewController *result = nil;
//    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else
//        result = window.rootViewController;
//    
//    return result;
//}
//

@end
