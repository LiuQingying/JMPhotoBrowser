//
//  UIView+Extension.h
//  actoys
//
//  Created by LiuQingying on 16/3/28.
//  Copyright © 2017年 LiuQingying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat yy_x;
@property (nonatomic, assign) CGFloat yy_y;
@property (nonatomic, assign) CGFloat yy_width;
@property (nonatomic, assign) CGFloat yy_height;
/**
 控件中心点X值
 */
@property (nonatomic, assign) CGFloat yy_centerX;
/**
 控件中心点Y值
 */
@property (nonatomic, assign) CGFloat yy_centerY;
/**
 控件最左边那根线的位置(minX的位置)
 */
@property (nonatomic, assign) CGFloat yy_left;
/**
 控件最右边那根线的位置(maxX的位置) 
 */
@property (nonatomic, assign) CGFloat yy_right;
/**
 控件最顶部那根线的位置(minY的位置)
 */
@property (nonatomic, assign) CGFloat yy_top;
/**
 控件最底部那根线的位置(maxY的位置)
 */
@property (nonatomic, assign) CGFloat yy_bottom;
/**
 *  将View及subviews scrollsToTop设为NO
 */
- (void)yy_disableScrollsToTopPropertyOnMeAndAllSubviews;
@end
