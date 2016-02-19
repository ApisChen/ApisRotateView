//
//  RotateCell.m
//  test
//
//  Created by 陈峰 on 16/2/17.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import "RotateCell.h"

@interface RotateCell ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation RotateCell
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    
    if (/* DISABLES CODE */ (0)) {
        if (_image) {
            CGFloat imageRatio = _image.size.width/_image.size.height;
            CGFloat w = CGRectGetWidth(self.bounds);
            CGFloat h = CGRectGetHeight(self.bounds);
            CGRect imageViewFrame = self.bounds;
            
            if (imageRatio<w/h) {
                imageViewFrame.size.width = h*imageRatio;
            } else {
                imageViewFrame.size.height = w/imageRatio;
            }
            
            _imageView.frame = imageViewFrame;
            _imageView.center = CGPointMake(w/2.f, h/2.f);
        }
    }
}


@end
