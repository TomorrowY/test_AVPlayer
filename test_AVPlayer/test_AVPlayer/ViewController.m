//
//  ViewController.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import "CommonAVPlayer.h"
#import "AVSynchronizedLayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayItemViewController.h"
#import "AVQueuePlayerViewController.h"
#import "VedioRecorder.h"


@interface ViewController ()

@end

#define OBTAIN_VC(ViewController) [[UIStoryboard storyboardWithName:@"AVPlayer" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)toCustomAvPlayerClicked:(id)sender {
    CommonAVPlayer *CAVPlayer = [[UIStoryboard storyboardWithName:@"AVPlayer" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([CommonAVPlayer class])];
    if (self.navigationController) {
        [self.navigationController pushViewController:CAVPlayer animated:true];
    }
    else{
        [self presentViewController:CAVPlayer animated:true completion:nil];
    }
}

- (IBAction)onAVSynchronizedClicked:(id)sender {
    AVSynchronizedLayerController *slCV = [[UIStoryboard storyboardWithName:@"AVPlayer" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([AVSynchronizedLayerController class])];
    [self.navigationController pushViewController:slCV animated:true];
}

- (IBAction)onPlayItemClicked:(id)sender {
    PlayItemViewController *piVC = [[UIStoryboard storyboardWithName:@"AVPlayer" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([PlayItemViewController class])];
    [self.navigationController pushViewController:piVC animated:true];
}

- (IBAction)onAVQueuePlayerViewControllerClicked:(id)sender {
    NSLog(@"AVQueuePlayerViewController");
    AVQueuePlayerViewController *vc = [[UIStoryboard storyboardWithName:@"AVPlayer" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([AVQueuePlayerViewController class])];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)onVedioRecorderClicked:(id)sender {
    VedioRecorder *vR = OBTAIN_VC(VedioRecorder);
    if (self.navigationController) {
        [self.navigationController pushViewController:vR animated:true];
    }else{
        [self presentViewController:vR animated:true completion:nil];
    }
    
}


@end
