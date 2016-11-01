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
{
    id _periodTimeObserver;
}

@property (weak, nonatomic) IBOutlet UIView *displaySubView;
@property (nonatomic) AVQueuePlayer *queuePlayer;
@property (weak, nonatomic) IBOutlet UIView *anotherSubView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_onPlaying:) name:@"AVPlayerItemPlaying" object:nil];

    
    NSMutableArray<AVPlayerItem *> * playerItems = [NSMutableArray<AVPlayerItem *> new];
    for (NSInteger index = 0 ; index < vedioNum; index++) {
        AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index]]];
        [playerItems addObject:[AVPlayerItem playerItemWithAsset:asset]];
    }
    self.queuePlayer = [[AVQueuePlayer alloc] initWithItems:playerItems];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.queuePlayer];
    playerLayer.frame = self.displaySubView.bounds;
    [self.displaySubView.layer insertSublayer:playerLayer atIndex:0];
    
    [self.queuePlayer pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onPlayerClicked:(id)sender {
    [self.queuePlayer play];
    
    /*
    _periodTimeObserver = [self.queuePlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AVPlayerItemPlaying" object:nil];
    }];
     */
}

- (IBAction)onPauseClicked:(id)sender {
    [self.queuePlayer pause];
}

- (IBAction)onNextClicked:(id)sender {
    NSLog(@"next ");
    
    if (self.queuePlayer.items == 0) {
        NSLog(@"所有视频已经播放完");
        return;
    }
    
    if (self.queuePlayer.items.count == 1) {
        NSLog(@"只剩下一个了");
        for (NSInteger index = 0 ; index < vedioNum; index++) {
            AVAsset *asset = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8000/movie/test%ld.mp4",(long)index]]];
            AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
            [self.queuePlayer insertItem:item afterItem:nil];
        }
    }
    
    [self.queuePlayer advanceToNextItem];

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

- (void)_onPlaying:(NSNotification *)notification {
    CMTime time = self.queuePlayer.currentItem.duration;
//    NSLog(@"time is : timescale:%d,timeValue: %lld",time.timescale,time.value);
    if (time.timescale == 0) {
        return;
    }
    NSInteger wholeSecond = time.value / time.timescale;
    NSLog(@"time : %ld",(long)wholeSecond);
    NSInteger min = wholeSecond / 60;
    NSInteger second = wholeSecond%60 ;
    self.timeLabel.text = [NSString stringWithFormat:@"当前片段时长: %ld:%ld",(long)min,(long)second];
}

@end
