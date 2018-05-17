//
//  StartViewController.m
//  IquorShopping
//
//  Created by nanli5 on 2018/5/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "StartViewController.h"
#import "ShowPictureView.h"

@interface StartViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ShowPictureViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *startContainer;
@property (weak, nonatomic) IBOutlet UITextView *inputText;
@property (weak, nonatomic) IBOutlet UILabel *placeholdLabel;
@property (weak, nonatomic) IBOutlet UIImageView *star01;
@property (weak, nonatomic) IBOutlet UIImageView *star02;
@property (weak, nonatomic) IBOutlet UIImageView *star03;
@property (weak, nonatomic) IBOutlet UIImageView *star04;
@property (weak, nonatomic) IBOutlet UIImageView *star05;
@property (nonatomic, strong) ShowPictureView *showPictureView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *imageStars;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(startUpload)];
    self.imageStars = [NSMutableArray arrayWithCapacity:5];
    self.imageArr = [NSMutableArray arrayWithCapacity:0];
    [self.imageStars addObject:self.star01];
    [self.imageStars addObject:self.star02];
    [self.imageStars addObject:self.star03];
    [self.imageStars addObject:self.star04];
    [self.imageStars addObject:self.star05];
    [self.view addSubview:self.showPictureView];
    CGFloat picH = ([UIScreen mainScreen].bounds.size.width-50)/4+20;
    [self.showPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.inputText.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(picH);
    }];
    
    
}


- (void)reloadStar:(CGPoint)touchPoint {
    NSLog(@"point = %@", NSStringFromCGPoint(touchPoint));
    CGRect rect = CGRectMake(0, 0, touchPoint.x, 24);
    UIImageView *star;
    for (int i =0; i< 5 ;i++) {
        star = self.imageStars[i];
        if (CGRectIntersectsRect(rect, star.frame)) {
            star.image = [UIImage imageNamed:@"icon_21"];
        }else {
            star.image = [UIImage imageNamed:@"icon_20"];
        }
    }
}


- (void)startUpload {
    
}

- (void)photoOrCamera{
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
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
    
    
    
}
- (void)chosPhotos {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [Dialog showMessage:@"不支持相册选择"];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<9.0) {
            picker.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        picker.allowsEditing = NO;
        picker.delegate = self;
        UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [currentVc presentViewController:picker animated:YES completion:^{
        }];
    }
    
}
- (void)chosCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [Dialog showMessage:@"不支持相机"];
    }else {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0&&[[[UIDevice currentDevice] systemVersion] floatValue]<9.0) {
            picker.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        }
        picker.allowsEditing = NO;
        picker.delegate = self;
        UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [currentVc presentViewController:picker animated:YES completion:^{
        }];
    }
}

#pragma mark - system
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.startContainer];
    if (CGRectContainsPoint(self.startContainer.bounds, touchPoint)) {
        [self reloadStar:touchPoint];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.startContainer];
    if (CGRectContainsPoint(self.startContainer.bounds, touchPoint)) {
        [self reloadStar:touchPoint];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ShowPictureViewDelegate
- (void)addButtonClick:(ShowPictureView *)ShowPictureView{
    [self photoOrCamera];
}
- (void)showPicClick:(ShowPictureView *)ShowPictureView clickedPicTag:(int)tag{
   
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.imageArr addObject:image];
    self.showPictureView.picArray = self.imageArr;
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [currentVc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark set & get
- (ShowPictureView *)showPictureView{
    if (!_showPictureView) {
        _showPictureView = [[ShowPictureView alloc] init];
        _showPictureView.isNeedAddBtn = YES;
        _showPictureView.isURL = NO;
        _showPictureView.delegate = self;
    }
    return _showPictureView;
}
@end
