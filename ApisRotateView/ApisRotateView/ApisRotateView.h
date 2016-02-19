//
//  ApisRotateView.h
//  test
//
//  Created by 陈峰 on 16/2/17.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionRight = 0,
    ScrollDirectionLeft,
};

@protocol ApisRotateViewDelegate <NSObject>

- (void)apisRotateView:(id)from clickedAtIndex:(NSInteger)index;

@end

IB_DESIGNABLE
@interface ApisRotateView : UIView

//轮播图，只支持UIImage
@property (nonatomic, strong) NSArray<UIImage *> *images;
//占位图
@property (nonatomic, strong) IBInspectable UIImage *placeholder;
//是否自动轮播
@property (nonatomic, assign) IBInspectable BOOL autoScroll;
//滚动时间间隔
@property (nonatomic, assign) IBInspectable CGFloat cycleTime;
//滚动方向 默认ScrollDirectionRight
@property (nonatomic, assign) ScrollDirection scrollDirection;
//pageControl外部引入
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, weak) id<ApisRotateViewDelegate> delegate;

//- (void)scroll:(ScrollDirection)direction;
//
//- (void)startTimer;
//- (void)suspendTimer;
//- (void)stopTimer;

@end
