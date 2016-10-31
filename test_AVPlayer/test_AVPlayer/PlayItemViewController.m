//
//  PlayItemViewController.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/31.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PlayItemViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayItemViewController ()
@property (weak, nonatomic) IBOutlet UIView *subView;

@end

@implementation PlayItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVariables];
}

- (void)initVariables {
    
    [self.subView layoutIfNeeded];
    
    AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test1.mp4"]];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithAsset:asset];
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];

    playerLayer.frame = self.subView.bounds;
    [self.subView.layer insertSublayer:playerLayer atIndex:0];
    
    [player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
