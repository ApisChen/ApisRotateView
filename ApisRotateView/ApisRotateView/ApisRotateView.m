//
//  ApisRotateView.m
//  test
//
//  Created by 陈峰 on 16/2/17.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "ApisRotateView.h"
#import "RotateCell.h"

@interface ApisRotateView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate> {
}

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation ApisRotateView

#pragma mark - getter/setter
- (void)setImages:(NSArray<UIImage *> *)images {
    _images = images;
    [self.collection reloadData];
    if (_images.count>1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
        });
    }
    
    if (_images.count>1 && _cycleTime>0 && _autoScroll) {
        [self startTimer];
    } else {
        [self stopTimer];
    }
}

- (UICollectionView *)collection {
    if (_collection==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.bounces = NO;
        _collection.backgroundColor = [UIColor clearColor];
        _collection.pagingEnabled = YES;
        [_collection registerClass:[RotateCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collection];
    }
    return _collection;
}

- (dispatch_source_t)timer {
    if (_images.count<=1 || _cycleTime<=0 || !_autoScroll) {
        return nil;
    }
    
    if (_timer==nil) {
        __block NSInteger count = 0;
        __weak ApisRotateView *weakSelf = self;
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), _cycleTime*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            if (count++>0) {
                [weakSelf scroll:_scrollDirection];
            }
        });
    }
    return _timer;
}

#pragma mark - collection代理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RotateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    NSInteger imageCount = _images.count;
    if (imageCount==0) {
        cell.image = _placeholder;//显示占位符
    } else if (imageCount==1) {
        cell.image = _images.firstObject;
    } else {
        if (indexPath.item==0) {
            cell.image = _images.lastObject;
        } else if (indexPath.item==imageCount+1) {
            cell.image = _images.firstObject;
        } else {
            cell.image = _images[indexPath.item-1];
        }
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger imageCount = _images.count;
    if (imageCount==0) {
        return _placeholder? 1:0;//无数据显示占位符
    } else {
        //_collection.contentOffset = CGPointMake(CGRectGetWidth(_collection.bounds), 0);
        return imageCount==1? 1:imageCount+2;//无限轮播
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collection.frame = self.bounds;
}

#pragma mark - 滚动方法
- (void)showImageAtIndex:(NSInteger)index animation:(BOOL)animation {
    NSInteger cellCount = _images.count;
    cellCount = cellCount>1? cellCount+2:cellCount;
    if (index>=0 && index<cellCount) {
        NSIndexPath *scrollIndexpath = [NSIndexPath indexPathForItem:index inSection:0];
        [_collection scrollToItemAtIndexPath:scrollIndexpath atScrollPosition:UICollectionViewScrollPositionRight animated:animation];
    }
}

#pragma mark - 自动滚动
- (void)scroll:(ScrollDirection)direction {
    NSInteger imageCount = _images.count;
    if (imageCount<=1) {
        return;
    }
    
    NSInteger currentItem = 0;
    if (direction==ScrollDirectionLeft) {
        currentItem = ceilf(_collection.contentOffset.x/CGRectGetWidth(_collection.bounds));
        if (currentItem>0) {
            [self showImageAtIndex:currentItem-1 animation:YES];
        }
    } else {
        currentItem = floorf(_collection.contentOffset.x/CGRectGetWidth(_collection.bounds));
        if (currentItem<imageCount+1) {
            [self showImageAtIndex:currentItem+1 animation:YES];
        }
    }
}

#pragma mark - 自动滚动判定
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self endlessLoopCategory];
}

#pragma mark - 手动滚动判断
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self suspendTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self endlessLoopCategory];
    [self startTimer];
}

- (void)endlessLoopCategory {
    NSInteger currentItem = _collection.contentOffset.x/CGRectGetWidth(_collection.bounds);
    NSInteger imageCount = _images.count;
    if (imageCount>1) {
        if (currentItem==0) {
            [self showImageAtIndex:imageCount animation:NO];
        } else if (currentItem==imageCount+1) {
            [self showImageAtIndex:1 animation:NO];
        }
    }
}

#pragma mark - timer控制
- (void)startTimer {
    if (_images.count>1 && _cycleTime>0 && _autoScroll) {
        dispatch_resume(self.timer);
    }
}

- (void)suspendTimer {
    if (_timer) {
        dispatch_suspend(_timer);
    }
}

- (void)stopTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
