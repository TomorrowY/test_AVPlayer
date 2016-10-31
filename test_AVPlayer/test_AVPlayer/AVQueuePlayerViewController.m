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
@property (weak, nonatomic) IBOutlet UIView *anotherSubView;

@end

@implementation AVQueuePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariables];
}

- (void)initVariables {
    [self.displaySubView layoutIfNeeded];
    [self.anotherSubView layoutIfNeeded];
    
    NSMutableArray<AVPlayerItem *> * playerItems = [NSMutableArray<AVPlayerItem *> new];
    for (NSInteger index =0 ; index < 3; index++) {
        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index]]];
        [playerItems addObject:[AVPlayerItem playerItemWithAsset:asset]];
    }
    self.queuePlayer = [[AVQueuePlayer alloc] initWithItems:playerItems];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.queuePlayer];
    playerLayer.frame = self.displaySubView.bounds;
    [self.displaySubView.layer insertSublayer:playerLayer atIndex:0];
    
   /*
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test0.mp4"]]]];
    CALayer *superLayer =  self.displaySubView.layer;
    AVSynchronizedLayer *syncLayer = [AVSynchronizedLayer synchronizedLayerWithPlayerItem:playerItem];
    [syncLayer addSublayer:self.anotherSubView.layer];
    [superLayer addSublayer:syncLayer];
    */
    
    [self.queuePlayer pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onPlayerClicked:(id)sender {
    [self.queuePlayer play];
}

- (IBAction)onPauseClicked:(id)sender {
    [self.queuePlayer pause];
}

- (IBAction)onNextClicked:(id)sender {
    NSLog(@"next");
}

- (IBAction)onPrevioustClicked:(id)sender {
    NSLog(@"previous");
}

@end
