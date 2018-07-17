//
//  EveGoodsView.m
//  IquorShopping
//
//  Created by nanli5 on 2018/7/17.
//  Copyright © 2018年 Hefei elevation network technology co. LTD. All rights reserved.
//

#import "EveGoodsView.h"
#import "ShowPictureView.h"
@interface EveGoodsView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ShowPictureViewDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *starContainer;
@property (weak, nonatomic) IBOutlet UITextView *eveContent;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoLeadingConstraint;
@property (nonatomic, strong) ShowPictureView *showPictureView;
@property (nonatomic, strong) NSMutableArray *starArrs;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *imageStrs;
@property (nonatomic, assign) int count;
@end

@implementation EveGoodsView


- (void)awakeFromNib {
    [super awakeFromNib];
    for (int i = 0; i<5; i++) {
        UIImageView *starImage = [[UIImageView alloc]initWithFrame:CGRectMake(25*i, 0, 20, 20)];
        starImage.image = [UIImage imageNamed:@"icon_20"];
        [self.starArrs addObject:starImage];
        [self.starContainer addSubview:starImage];
    }
    self.count = 0;
    self.photoButton.hidden = YES;
    [self addSubview:self.showPictureView];
    self.eveContent.delegate = self;
    
}

- (void)uploadImage:(UIImage *)image {
    [AFNetworkTool requestWithUrl:user_uploadCommentFile params:nil picImageArray:@[image] fileName:@"file" success:^(id responseObject) {
        NSInteger status = [responseObject[@"code"] integerValue];
        if (status == 200) {
            [self.imageStrs addObject:responseObject[@"content"][@"img_url"]];
        }
    } fail:^{
    }];
}
- (IBAction)buttomSubmitClick:(id)sender {
    NSString *imageStr = [self.imageStrs componentsJoinedByString:@","];
    NSDictionary *param = @{@"order_id":self.order_id,
                            @"goods_id":self.goods_id,
                            @"comment":self.eveContent.text,
                            @"status":[NSString stringWithFormat:@"%i", self.count],
                            @"images":imageStr
                            };
    
    [AFNetworkTool postJSONWithUrl:user_addGoodsComment parameters:param success:^(id responseObject) {
        NSInteger code = [responseObject[@"code"] integerValue];
        [Dialog popTextAnimation:responseObject[@"message"]];
        if (code == 200) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [NSObject.getCurrentVC.navigationController popViewControllerAnimated:YES];
            });
        }
    } fail:^{
        
    }];
}

- (void)reloadStar:(CGPoint)touchPoint {
    NSLog(@"point = %@", NSStringFromCGPoint(touchPoint));
    CGRect rect = CGRectMake(0, 0, touchPoint.x, 24);
    UIImageView *star;
    self.count = 0;
    for (int i =0; i< 5 ;i++) {
        star = self.starArrs[i];
        if (CGRectIntersectsRect(rect, star.frame)) {
            star.image = [UIImage imageNamed:@"icon_21"];
            self.count++;
        }else {
            star.image = [UIImage imageNamed:@"icon_20"];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.showPictureView.frame = CGRectMake(0, self.photoButton.frame.origin.y, self.frame.size.width, 100);
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
        picker.allowsEditing = NO;
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
        picker.allowsEditing = NO;
        picker.delegate = self;
        UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        [currentVc presentViewController:picker animated:YES completion:^{
        }];
    }
}
#pragma mark ShowPictureViewDelegate
- (void)addButtonClick:(ShowPictureView *)ShowPictureView{
    [self photoOrCamera];
}
- (void)showPicClick:(ShowPictureView *)ShowPictureView clickedPicTag:(int)tag{
    
}
- (void)textViewDidChange:(UITextView *)textView {
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.imageArr addObject:image];
    self.showPictureView.picArray = self.imageArr;
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [currentVc dismissViewControllerAnimated:YES completion:nil];
    [self uploadImage:image];
}

- (IBAction)photoButtonClick:(id)sender {
    
}


#pragma mark - system
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.starContainer];
    if (CGRectContainsPoint(self.starContainer.bounds, touchPoint)) {
        [self reloadStar:touchPoint];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.starContainer];
    if (CGRectContainsPoint(self.starContainer.bounds, touchPoint)) {
        [self reloadStar:touchPoint];
    }
}


- (NSMutableArray *)starArrs {
    if (!_starArrs) {
        _starArrs = [NSMutableArray array];
    }
    return _starArrs;
}
- (NSMutableArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (NSMutableArray *)imageStrs {
    if (!_imageStrs) {
        _imageStrs = [NSMutableArray array];
    }
    return _imageStrs;
}
#pragma mark set & get
- (ShowPictureView *)showPictureView{
    if (!_showPictureView) {
        _showPictureView = [[ShowPictureView alloc] init];
        _showPictureView.isNeedAddBtn = YES;
        _showPictureView.isURL = NO;
        _showPictureView.delegate = self;
        _showPictureView.MaxNum = 3;
    }
    return _showPictureView;
}
@end
