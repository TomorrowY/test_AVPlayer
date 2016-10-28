//
//  CustomAVPlayer.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "CustomAVPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface CustomAVPlayer ()
@property (weak, nonatomic) IBOutlet UIView *displayMovieView;
@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerLayer *playerLayer;
@property (weak, nonatomic) IBOutlet UIButton *playerbtn;

@end

@implementation CustomAVPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIKit];
   
    [self initPlayer];
}

- (void)initUIKit {
  
}

- (void)onBackClicked:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)initPlayer {
//    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test1.mp4"]];
    /// 几个初始化的方法
//    + (instancetype)playerWithURL:(NSURL *)URL;
//    + (instancetype)playerWithPlayerItem:(nullable AVPlayerItem *)item;
//    - (instancetype)initWithURL:(NSURL *)URL;
//    - (instancetype)initWithPlayerItem:(nullable AVPlayerItem *)item;

    [self.displayMovieView layoutIfNeeded];
    self.player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test1.mp4"]];
    self.playerLayer = [AVPlayerLayer new];
   
    self.playerLayer.frame = self.displayMovieView.bounds;
    [self.displayMovieView.layer addSublayer:self.playerLayer];
    self.playerLayer.player = self.player; //简历layer 和player之间的关系
//    [self.player play];
    
    [self testInfo];
}

- (IBAction)toBackClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)toRotateClicked:(id)sender {
    NSLog(@"选装屏幕");
    
}

- (void)testInfo {
    AVPlayerStatus playerStatus = self.player.status;
    NSLog(@"playerStatus : %ld",(long)playerStatus);
    NSError *error = self.player.error;
    NSLog(@"error : %@",error);
    
#pragma mark -- AVPlayer (AVPlayerPlaybackControl)
    
    CGFloat rate = self.player.rate;
//    - (void)play;
//    - (void)pause;
//    typedef NS_ENUM(NSInteger, AVPlayerTimeControlStatus) {
//        AVPlayerTimeControlStatusPaused,
//        AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate,
//        AVPlayerTimeControlStatusPlaying
//    } NS_ENUM_AVAILABLE(10_12, 10_0);
//    @property (nonatomic, readonly) AVPlayerTimeControlStatus timeControlStatus NS_AVAILABLE(10_12, 10_0);
}

- (IBAction)onPlayerClicked:(id)sender {
    self.playerbtn.selected = !self.playerbtn.selected;
    if (self.playerbtn.selected) {
        [self.player play];
    }
    else{
        [self.player pause];
    }
 
    
    UITraitCollection
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
