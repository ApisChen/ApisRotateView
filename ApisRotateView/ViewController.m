//
//  ViewController.m
//  ApisRotateView
//
//  Created by 陈峰 on 16/2/19.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "ViewController.h"
#import "ApisRotateView.h"

@interface ViewController ()<ApisRotateViewDelegate> {

    __weak IBOutlet ApisRotateView *rotateView;
    __weak IBOutlet UIPageControl *pageControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    rotateView.scrollDirection = ScrollDirectionLeft;
    UIImage *image1 = [UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"3"];
    UIImage *image4 = [UIImage imageNamed:@"4"];
    rotateView.images = @[image1,image2,image3,image4];
    rotateView.delegate = self;
    rotateView.pageControl = pageControl;
    //rotateView.scrollDirection = ScrollDirectionRight;
}

- (void)apisRotateView:(id)from clickedAtIndex:(NSInteger)index {
    NSLog(@"click at index %ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
