//
//  JMTableViewCell.m
//  JMPhotoBrowser
//
//  Created by LiuQingying on 2017/8/8.
//  Copyright © 2017年 LiuQingying. All rights reserved.
//

#import "JMTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface JMTableViewCell()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pictureView1;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView2;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView3;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView0;
/**
 图片数组
 */
@property (nonatomic, strong) NSMutableArray *picturesArr;

@end

@implementation JMTableViewCell

- (NSMutableArray *)picturesArr{
    if (!_picturesArr) {
        _picturesArr = [NSMutableArray arrayWithCapacity:4];
    }
    return _picturesArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    tap0.delegate = self;
    [self.pictureView0 addGestureRecognizer:tap0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    tap.delegate = self;
    [self.pictureView1 addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    tap1.delegate = self;
    [self.pictureView2 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPicture:)];
    tap2.delegate = self;

    [self.pictureView3 addGestureRecognizer:tap2];
    
    [self.picturesArr addObject:self.pictureView0];
    [self.picturesArr addObject:self.pictureView1];
    [self.picturesArr addObject:self.pictureView2];
    [self.picturesArr addObject:self.pictureView3];
    
}

- (void)setImageView:(NSArray *)imageArr{
    
    NSInteger index0 = arc4random()%(imageArr.count-1);
    [self.pictureView0 sd_setImageWithURL:[NSURL URLWithString:imageArr[index0]]];

    NSInteger index1 = arc4random()%(imageArr.count-1);
    [self.pictureView1 sd_setImageWithURL:[NSURL URLWithString:imageArr[index1]]];
    NSInteger index2 = arc4random()%(imageArr.count-1);
    [self.pictureView2 sd_setImageWithURL:[NSURL URLWithString:imageArr[index2]]];
    NSInteger index3 = arc4random()%(imageArr.count-1);
    [self.pictureView3 sd_setImageWithURL:[NSURL URLWithString:imageArr[index3]]];
    
    
}
- (void)tapPicture:(UITapGestureRecognizer *)tap{
    if (self.clickPictureView) {
        self.clickPictureView(self.picturesArr,tap.view.tag);
    }
}
@end
