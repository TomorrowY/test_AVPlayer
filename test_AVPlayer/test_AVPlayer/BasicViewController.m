//
//  BasicViewController.m
//  test_AVPlayer
//
//  Created by felix on 2016/10/28.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- UITraitEnvironment method override

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection NS_AVAILABLE_IOS(8_0) {
    NSLog(@"%@",previousTraitCollection);
}

@end
