//
//  VedioRecorder.m
//  test_AVPlayer
//
//  Created by felix on 2016/11/3.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "VedioRecorder.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface VedioRecorder ()<AVCaptureFileOutputRecordingDelegate>

@property (weak, nonatomic) IBOutlet UIView *vedioPreview;

@property (nonatomic) AVCaptureDevice *captureDevice;
//@property (nonatomic) AVCaptureInput *captureInput;
//@property (nonatomic) AVCaptureOutput *captureOutput;
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureFlashMode captureFlashMode;

@property (nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic) AVCaptureDeviceInput *captureDeviceInput;
//@property (nonatomic) AVCaptureStillImageOutput *captureStillImageOutput;
@property (strong,nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;//视频输出流


@end

@implementation VedioRecorder

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];
    
}

- (void) initVariables {

    [self configureCaptureSeesion];
    
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
    
    // 添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    
    //输入设备初始化蔬菜如对象，用于获取输入数据（手机摄像头、麦克风等等的输入（对象，声音、视频））
    NSError *error = nil;
    _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_captureDevice error:&error];
    if (error) {
        NSLog(@"获取输入对象时候出现了错误，错误原因：%@",error.localizedDescription);
        return;
    }
    
    AVCaptureDeviceInput *audioCaptureInput = [[AVCaptureDeviceInput alloc] initWithDevice:audioCaptureDevice error:&error];
    if (error) {
        NSLog(@"音频设置尤为浸提的、");
        return ;
    }
    //初始化输出对象，用于获得输出数据
//    _captureStillImageOutput = [AVCaptureStillImageOutput new];
//    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
//    [_captureStillImageOutput setOutputSettings:outputSettings]; //输出设置
    
    _captureMovieFileOutput = [AVCaptureMovieFileOutput new];
    
    
    
    //input session
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:audioCaptureInput];
    
        AVCaptureConnection *captureConnection = [_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureConnection isVideoStabilizationSupported]) {
            captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
    
    //output session
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
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

// 视频录制
- (IBAction)onRecorderClicked:(id)sender {
    
    AVCaptureConnection *captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    if (![self.captureMovieFileOutput isRecording]) {
        if ([[UIDevice currentDevice] isMultitaskingSupported]) {
            
            captureConnection.videoOrientation=[self.captureVideoPreviewLayer connection].videoOrientation;
            NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"];
            NSLog(@"save path is :%@",outputFielPath);
            NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
            [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
        }
    }
    else{
        [self.captureMovieFileOutput stopRecording];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 视频输出代理
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    NSLog(@"开始录制...");
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    NSLog(@"视频录制完成.");
    //视频录入完成之后在后台将视频存储到相簿
//    UIBackgroundTaskIdentifier lastBackgroundTaskIdentifier = self.backgroundTaskIdentifier;
//    self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc]init];
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            NSLog(@"保存视频到相簿过程中发生错误，错误信息：%@",error.localizedDescription);
        }
//        if (lastBackgroundTaskIdentifier!=UIBackgroundTaskInvalid) {
//            [[UIApplication sharedApplication] endBackgroundTask:lastBackgroundTaskIdentifier];
//        }
        NSLog(@"成功保存视频到相簿.");
    }];
    
}

- (IBAction)onRecordFinishedClicked:(id)sender {
    [self.captureMovieFileOutput stopRecording];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }
    else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}


@end
