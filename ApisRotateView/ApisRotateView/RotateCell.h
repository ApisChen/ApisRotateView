//
//  RotateCell.h
//  test
//
//  Created by 陈峰 on 16/2/17.
//  Copyright © 2016年 陈峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UICollectionViewCellImageLayoutType) {
    UICollectionViewCellImageLayoutCenter=0,
    UICollectionViewCellImageLayoutTile,
};

@interface RotateCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) UICollectionViewCellImageLayoutType *imageLayoutType;

@end
