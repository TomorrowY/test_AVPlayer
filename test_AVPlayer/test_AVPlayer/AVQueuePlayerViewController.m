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

static NSInteger vedioNum = 3;
static NSInteger initIndex = 0;

@implementation AVQueuePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVariables];
}

- (void)initVariables {
    [self.displaySubView layoutIfNeeded];
    [self.anotherSubView layoutIfNeeded];
    
    NSMutableArray<AVPlayerItem *> * playerItems = [NSMutableArray<AVPlayerItem *> new];
    for (NSInteger index = 0 ; index < vedioNum; index++) {
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
    NSLog(@"next ");
    [self.queuePlayer advanceToNextItem];
    if (self.queuePlayer.items.count == 1) {
        NSLog(@"只剩下一个了");
        for (NSInteger index = 0 ; index < vedioNum; index++) {
            AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index]]];
            AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
            [self.queuePlayer insertItem:item afterItem:nil];
        }
    }
}

- (IBAction)onPrevioustClicked:(id)sender {
    NSLog(@"previous ");
    NSArray *playItems = [self.queuePlayer items];
    
    if (playItems.count == vedioNum) {
        AVPlayerItem *previousItem = self.queuePlayer.items.lastObject;
        [previousItem seekToTime:kCMTimeZero];
        [self.queuePlayer removeAllItems];
        [self.queuePlayer insertItem:previousItem afterItem:nil];
        for (NSInteger index =0 ; index <playItems.count -1; index ++) {
            [self.queuePlayer insertItem:playItems[index] afterItem:nil];
        }
    }else{
        AVPlayerItem *previousItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)(vedioNum - playItems.count -1)]]];
        [previousItem seekToTime:kCMTimeZero];
        [self.queuePlayer removeAllItems];
        [self.queuePlayer insertItem:previousItem afterItem:nil];
        for (NSInteger index =0 ; index <playItems.count ; index ++) {
            [self.queuePlayer insertItem:playItems[index] afterItem:nil];
        }
    }
    
}

@end
