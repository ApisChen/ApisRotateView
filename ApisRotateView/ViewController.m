//
//  ViewController.m
//  ApisRotateView
//
//  Created by 陈峰 on 16/2/19.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "ViewController.h"
#import "ApisRotateView.h"

@interface ViewController () {

    __weak IBOutlet ApisRotateView *rotateView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    rotateView.scrollDirection = ScrollDirectionLeft;
    UIImage *image1 = [UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"3"];
    rotateView.images = @[image1,image2,image3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
