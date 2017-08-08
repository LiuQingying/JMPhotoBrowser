//
//  UIView+Extension.m
//  actoys
//
//  Created by LiuQingying on 16/3/28.
//  Copyright © 2016年 Actoys.net. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setYy_x:(CGFloat)yy_x
{
    CGRect frame = self.frame;
    frame.origin.x = yy_x;
    self.frame = frame;
}

- (CGFloat)yy_x
{
    return self.frame.origin.x;
}

- (void)setYy_y:(CGFloat)yy_y{
    CGRect frame = self.frame;
    frame.origin.y = yy_y;
    self.frame = frame;
}

- (CGFloat)yy_y
{
    return self.frame.origin.y;
}

- (void)setYy_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)yy_width
{
    return self.frame.size.width;
}

- (void)setYy_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)yy_height
{
    return self.frame.size.height;
}

- (void)setYy_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)yy_centerX
{
    return self.center.x;
}

- (void)setYy_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)yy_centerY
{
    return self.center.y;
}

- (void)setYy_left:(CGFloat)yy_left
{
    self.yy_x = yy_left;
}

- (CGFloat)yy_left
{
    return self.yy_x;
}

- (void)setYy_top:(CGFloat)top
{
    self.yy_y = top;
}

- (CGFloat)yy_top
{
    return self.yy_y;
}

- (void)setYy_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)yy_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setYy_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)yy_bottom
{
    return CGRectGetMaxY(self.frame);
}
- (void)yy_disableScrollsToTopPropertyOnMeAndAllSubviews {
    if ([self isKindOfClass:[UIScrollView class]]) {
        ((UIScrollView *)self).scrollsToTop = NO;
    }
    for (UIView *subview in self.subviews) {
        [subview yy_disableScrollsToTopPropertyOnMeAndAllSubviews];
    }
}
@end
