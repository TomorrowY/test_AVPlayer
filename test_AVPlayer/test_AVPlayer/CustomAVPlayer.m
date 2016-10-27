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
@property (nonatomic) AVPlayer *avPlayer;
@property (nonatomic) AVPlayerLayer *playerLayer;
@end

@implementation CustomAVPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initPlayer];
}

- (void)initPlayer {
//    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test1.mp4"]];
    /// 几个初始化的方法
//    + (instancetype)playerWithURL:(NSURL *)URL;
//    + (instancetype)playerWithPlayerItem:(nullable AVPlayerItem *)item;
//    - (instancetype)initWithURL:(NSURL *)URL;
//    - (instancetype)initWithPlayerItem:(nullable AVPlayerItem *)item;

    [self.displayMovieView layoutIfNeeded];
    self.avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test1.mp4"]];
    self.playerLayer = [AVPlayerLayer new];
   
    self.playerLayer.frame = self.displayMovieView.bounds;
    [self.displayMovieView.layer addSublayer:self.playerLayer];
    self.playerLayer.player = self.avPlayer; //简历layer 和player之间的关系
    [self.avPlayer play];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
