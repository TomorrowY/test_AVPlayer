//
//  VedioRecorder.m
//  test_AVPlayer
//
//  Created by felix on 2016/11/3.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "VedioRecorder.h"
#import <AVFoundation/AVFoundation.h>

@interface VedioRecorder ()

@property (weak, nonatomic) IBOutlet UIView *vedioPreview;

@property (nonatomic) AVCaptureDevice *captureDevice;
//@property (nonatomic) AVCaptureInput *captureInput;
//@property (nonatomic) AVCaptureOutput *captureOutput;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureFlashMode captureFlashMode;

@property (nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic) AVCaptureDeviceInput *captureDeviceInput;
@property (nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;

@end

@implementation VedioRecorder

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
    
}

- (void) initVariables {

    [self configureCaptureSeesion];
    
    [self configureDevice];
    
}

- (void)configureCaptureSeesion {
    
    _captureSession = [AVCaptureSession new];

    //设置分辨率
//    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetMedium]) {
//        [_captureSession setSessionPreset:AVCaptureSessionPresetMedium];
//    }
    
    //获取输入设备
    _captureDevice = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
    if (!_captureDevice) {
        NSLog(@"failure get the back position device");
        return;
    }
    
    //输入设备初始化蔬菜如对象，用于获取输入数据（手机摄像头、麦克风等等的输入（对象，声音、视频））
    NSError *error = nil;
    _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_captureDevice error:&error];
    if (error) {
        NSLog(@"获取输入对象时候出现了错误，错误原因：%@",error.localizedDescription);
        return;
    }
    
    //初始化输出对象，用于获得输出数据
    _captureStillImageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [_captureStillImageOutput setOutputSettings:outputSettings]; //输出设置
    
    //input session
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    //output session
    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
        [_captureSession addOutput:_captureStillImageOutput];
    }
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];

    _vedioPreview.layer.masksToBounds = true;
    _captureVideoPreviewLayer.frame = _vedioPreview.bounds;
    
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill; //填充模式
    [_vedioPreview.layer insertSublayer:_captureVideoPreviewLayer above:_vedioPreview.layer];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_captureSession startRunning];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_captureSession stopRunning];
}

//获取摄像头
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
  NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
  for (AVCaptureDevice *camera in cameras) {
      if ([camera position]==position) {
          return camera;
      }
  }
  return nil;
}
                      
                      
- (void)configureDevice {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
//-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
//    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
//    NSError *error;
//    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
//    if ([captureDevice lockForConfiguration:&error]) {
//        propertyChange(captureDevice);
//        [captureDevice unlockForConfiguration];
//    }else{
//        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
//    }
//}

/**
 *  设置闪光灯模式
 *
 *  @param flashMode 闪光灯模式
 */
//-(void)setFlashMode:(AVCaptureFlashMode )flashMode{
//    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
//        if ([captureDevice isFlashModeSupported:flashMode]) {
//            [captureDevice setFlashMode:flashMode];
//        }
//    }];
//}


@end
