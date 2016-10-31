//
//  AVQueuePlayerViewController.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/31.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "AVQueuePlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVQueuePlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *displaySubView;
@property (nonatomic) AVQueuePlayer *queuePlayer;
@end

@implementation AVQueuePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariables];
}

- (void)initVariables {
    [self.displaySubView layoutIfNeeded];
    
    NSMutableArray<AVPlayerItem *> * playerItems = [NSMutableArray<AVPlayerItem *> new];
    for (NSInteger index =0 ; index < 3; index++) {
        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index]]];
        [playerItems addObject:[AVPlayerItem playerItemWithAsset:asset]];
    }
    self.queuePlayer = [[AVQueuePlayer alloc] initWithItems:playerItems];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.queuePlayer];
    playerLayer.frame = self.displaySubView.bounds;
    [self.displaySubView.layer insertSublayer:playerLayer atIndex:0];
    
    [self.queuePlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
