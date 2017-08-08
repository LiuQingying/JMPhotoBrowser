//
//  JMShowBigPictureCell.h
//  点击cell查看大图
//
//  Created by LiuQingying on 2017/8/1.
//  Copyright © 2017年 LiuQingying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
@class JMBigPictureView,DACircularProgressView,FLAnimatedImageView;

@interface JMShowBigPictureCell : UICollectionViewCell
@property (nonatomic, copy) void (^singleTapGestureBlock)(CGRect rect);
@property (nonatomic, strong) JMBigPictureView *bigPictureView;
- (void)recoverSubviews:(BOOL)animate;

@end

@interface JMBigPictureView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) FLAnimatedImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;
@property (nonatomic, strong) DACircularProgressView *progressView;
@property (nonatomic, copy) void (^singleTapGestureBlock)(CGRect rect);
/**
 点击图片的位置
 */
@property (nonatomic, assign) CGRect currentRect;

/**
 设置网络图片
 */
- (void)setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholder;
/**
 设置本地图片
 */
- (void)setImageWithName:(NSString *)name;
- (void)recoverSubviews:(BOOL)animate;

@end
