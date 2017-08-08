//
//  JMTableViewCell.h
//  JMPhotoBrowser
//
//  Created by LiuQingying on 2017/8/8.
//  Copyright © 2017年 LiuQingying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMTableViewCell : UITableViewCell

typedef void (^clickPictureViewBlock)(NSArray *pictureArr,NSInteger tag);
- (void)setImageView:(NSArray *)imageArr;
/**
 点击图片
 */
@property (nonatomic, strong) clickPictureViewBlock clickPictureView;

@end
