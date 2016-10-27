//
//  ViewController.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import "CustomAVPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)toCustomAvPlayerClicked:(id)sender {

    CustomAVPlayer *CAVPlayer = [[UIStoryboard storyboardWithName:@"AVPlayer" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([CustomAVPlayer class])];
    if (self.navigationController) {
        [self.navigationController pushViewController:CAVPlayer animated:true];
    }
    else{
        [self presentViewController:CAVPlayer animated:true completion:nil];
    }
    
}

@end
