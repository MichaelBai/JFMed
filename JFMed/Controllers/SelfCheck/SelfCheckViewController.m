//
//  SelfCheckViewController.m
//  JFMed
//
//  Created by Michael on 7/22/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckViewController.h"
#import "MBRotateControl.h"
#import "LLSimpleCamera.h"
#import "DoctorsViewController.h"
#import "SelfCheckResultViewController.h"

static const CGFloat kControlHeight = 122.5;

@interface SelfCheckViewController () <MBRotateDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) UILabel *angleLabel;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) LLSimpleCamera *camera;

@end

@implementation SelfCheckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = HEXColor(0xe5e5e5);
    self.title = @"脊柱自查";
    
    [self setupOverlay];
    
    self.camera = [[LLSimpleCamera alloc] init];
//    CGRect screenRect = self.view.bounds;
    [self.camera attachToViewController:self withFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- NAV_HEIGHT - kControlHeight)];
    
    [self.view addSubview:_overlayView];
    
//    UIImagePickerControllerSourceType sourceType;
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        sourceType = UIImagePickerControllerSourceTypeCamera;
//    } else {
//        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    imagePicker.sourceType = sourceType;
//    imagePicker.delegate  = self;
////    imagePicker.allowsEditing = NO;
////    imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
////    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
//    imagePicker.showsCameraControls = NO;
//    imagePicker.navigationBarHidden = NO;
//    imagePicker.toolbarHidden = YES;
////    imagePicker.edgesForExtendedLayout = UIRectEdgeNone;
////    imagePicker.cameraOverlayView = self.overlayView;
//    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // start the camera
    [self.camera start];
}

- (void)setupOverlay
{
    _overlayView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UIView *dashLineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-1.5, NAV_HEIGHT + 15, 3, SCREEN_HEIGHT - NAV_HEIGHT - kControlHeight - 30)];
    [_overlayView addSubview:dashLineView];
    [self drawDashLine:dashLineView lineLength:10 lineSpacing:2 lineColor:COLOR_THEME];
    
    MBRotateControl *rotateControl = [[MBRotateControl alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    rotateControl.delegate = self;
    [_overlayView addSubview:rotateControl];
    
    self.angleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 550, SCREEN_WIDTH, 20)];
    self.angleLabel.textAlignment = NSTextAlignmentCenter;
    [_overlayView addSubview:self.angleLabel];
    
    UIView *controlView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - kControlHeight, SCREEN_WIDTH, kControlHeight)];
    controlView.backgroundColor = [UIColor whiteColor];
    [_overlayView addSubview:controlView];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.frame = CGRectMake((SCREEN_WIDTH-67)/2, 27.5, 67, 67);
    [photoBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateHighlighted];
    [photoBtn addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:photoBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 36, 50, 50);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(closeCamera) forControlEvents:UIControlEventTouchUpInside];
    [controlView addSubview:closeBtn];
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)takePicture
{
    self.view.userInteractionEnabled = NO;
    [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
        [self.camera stop];
        if(!error) {
            NSDictionary *params = @{@"phoneNum":@"18533675226"};
            [NETWORK uploadImage:image params:params completionHandler:^(NSString *imgUrl, NSError *error) {
                if (error) {
                    [self.view showToast:error.userInfo[kErrorUserInfoMsgKey]];
                } else {
                    SelfCheckResultViewController *resultVC = [[SelfCheckResultViewController alloc] initWithAngle:self.angle];
                    [self.navigationController pushViewController:resultVC animated:YES];
                }
            }];
        } else {
            NSLog(@"An error has occured: %@", error);
        }
    } exactSeenImage:YES];
}

- (void)closeCamera
{
#warning test
    SelfCheckResultViewController *resultVC = [[SelfCheckResultViewController alloc] initWithAngle:18];
    [self.navigationController pushViewController:resultVC animated:YES];
    
//    [self.camera stop];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    float imageWidth = originImage.size.width;
    float imageHeight = originImage.size.height;
    
    if (imageWidth >= 750 || imageHeight >= 750) {
        float factor = imageWidth/imageHeight;
        CGRect sourceRect,destRect;
        if (originImage.imageOrientation == UIImageOrientationLeft || originImage.imageOrientation == UIImageOrientationRight) {
            sourceRect = CGRectMake(0, 0, imageHeight, imageWidth);
        }else{
            sourceRect = CGRectMake(0, 0, imageWidth, imageHeight);
        }
        
        destRect = CGRectMake(0, 0, 750, 750/factor);
        
        UIGraphicsBeginImageContextWithOptions(destRect.size, NO, 1.0); // 0.0 for scale means "correct scale for device's main screen".
        CGImageRef sourceImg = CGImageCreateWithImageInRect([originImage CGImage], sourceRect); // cropping happens here.
        originImage = [UIImage imageWithCGImage:sourceImg scale:0.0 orientation:originImage.imageOrientation]; // create cropped UIImage.
        [originImage drawInRect:destRect]; // the actual scaling happens here, and orientation is taken care of automatically.
        CGImageRelease(sourceImg);
        originImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    [NETWORK uploadImage:originImage completionHandler:^(ImageModel *imageInfo, NSError *error) {
//        if (error) {
//            [self showToastMessage:error.userInfo[kErrorUserInfoMsgKey]];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//        } else {
//            DATACENTER.currentUser.userHeadImage = imageInfo.thumbnailImagePath;
//            [NETWORK Post:API.Buyer.Update params:InitParam.append(@"image_id",imageInfo.ID) handler:^(id response, NSError *error, BOOL updatePage) {
//                if (error) {
//                    [self showToastMessage:error.userInfo[kErrorUserInfoMsgKey]];
//                    [picker dismissViewControllerAnimated:YES completion:nil];
//                } else {
//                    [picker dismissViewControllerAnimated:YES completion:^{
//                        HigirlMySettingLogoCell *cell = (HigirlMySettingLogoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//                        cell.logo.image = originImage;
//                        [self.tableView reloadData];
//                    }];
//                }
//            }];
//        }
//    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MBRotateDelegate

- (void)angleDidChangeTo:(CGFloat)angle
{
    self.angle = angle;
    self.angleLabel.text = [NSString stringWithFormat:@"当前角度：%.0f度", fabs(angle)];
}

@end
