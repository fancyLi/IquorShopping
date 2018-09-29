//
//  ImageViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/6/7.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "ImageViewController.h"
@interface ImageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
@implementation ImageViewController

+  (instancetype)shareImageVC {
    static ImageViewController *imageVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageVC = [[ImageViewController alloc]init];
    });
    return imageVC;
}
- (void)choosePhotoOrCamera {
    //点用相机
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosPhotos];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chosCamera];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:photoAction];
    [alertVC addAction:cameraAction];
    [alertVC addAction:cancelAction];
    [NSObject.getCurrentVC presentViewController:alertVC animated:YES completion:^{
        
    }];
}

- (void)chosPhotos {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [Dialog popTextAnimation:@"不支持相册选择"];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<9.0) {
            picker.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        picker.allowsEditing = YES;
        picker.delegate = self;
        UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [currentVc presentViewController:picker animated:YES completion:^{
        }];
    }
    
}
- (void)chosCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [Dialog popTextAnimation:@"不支持相机"];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<9.0) {
            picker.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        picker.allowsEditing = YES;
        picker.delegate = self;
        UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [currentVc presentViewController:picker animated:YES completion:^{
        }];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (self.imageChooseBlock) {
        self.imageChooseBlock(image);
    }
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [currentVc dismissViewControllerAnimated:YES completion:nil];
}

@end
