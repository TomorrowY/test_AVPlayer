//
//  AVSynchronizedLayerControllerViewController.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/31.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "AVSynchronizedLayerController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVSynchronizedLayerController ()

@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerLayer * avLayer;

@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIView *subView1;

@end

@implementation AVSynchronizedLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVariables];
}

- (void)initVariables {
    
    //AVSynchronizedLayer 好像这个layer没有怎么使用
    //AVPlayerItem* pItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test.mp4"]];
    //self.sLayer = [AVSynchronizedLayer synchronizedLayerWithPlayerItem:pItem];
    //_sLayer.playerItem = pItem;
    //_sLayer.frame = self.view.bounds;
    //[self.view.layer addSublayer:_sLayer];
    //self.player = [[AVPlayer alloc] initWithPlayerItem:pItem];

    self.player = [[AVPlayer alloc] init];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://localhost:8000/movie/test.mp4"]];
    self.avLayer = [[AVPlayerLayer alloc] init];

    // Set up a synchronized layer to sync the layer timing of its subtree
    // with the playback of the playerItem
    AVSynchronizedLayer *syncLayer = [AVSynchronizedLayer synchronizedLayerWithPlayerItem:playerItem];
    [syncLayer addSublayer:self.subView.layer];    // These sublayers will be synchronized.
    [self.subView1.layer addSublayer:syncLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onPlayerClicked:(id)sender {
    [self.player play];
}

@end
