//
//  JMShowBigPictureView.m
//  点击cell查看大图
//
//  Created by LiuQingying on 2017/8/1.
//  Copyright © 2017年 LiuQingying. All rights reserved.
//

#import "JMShowBigPictureView.h"
#import "JMShowBigPictureCell.h"
#import "UIView+Extension.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define YYColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define YYAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define YYGrayColor(r) YYColor(r,r,r)
@interface JMShowBigPictureView()
/** indexLabel 图片序号指示器 */
@property (nonatomic, strong) UILabel *indexLabel;
/**
 显示当前序号的window
 */
@property (nonatomic, strong) UIWindow *indexWindow;
/**
 动画效果
 */
@property (nonatomic, assign) BOOL needAnimate;
@end
static NSString *const showBigPictureCellID = @"showBigPictureCellID";
@implementation JMShowBigPictureView
- (UILabel *)indexLabel{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.backgroundColor = YYAColor(0, 0, 0, 0.6);
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.font = [UIFont systemFontOfSize:15];
        self.indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.index+1, _iconArray.count];
    }
    return _indexLabel;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.needAnimate = YES;
    if (_index) [self setContentOffset:CGPointMake((self.frame.size.width) * _index, 0) animated:NO];
    if (!_indexLabel&&_iconArray.count>1) {
        self.indexWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [_indexWindow setBackgroundColor:[UIColor clearColor]];
        [_indexWindow setWindowLevel:UIWindowLevelAlert + 1];
        [_indexWindow makeKeyAndVisible];
        [_indexWindow addSubview:self.indexLabel];
        [self performSelector:@selector(hideIndex) withObject:nil afterDelay:1];
    }


}
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        UICollectionViewFlowLayout *layout1 = (UICollectionViewFlowLayout *)layout;
        layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout1.itemSize = CGSizeMake(kScreenWidth+20, kScreenHeight);
        layout1.minimumInteritemSpacing = 0;
        layout1.minimumLineSpacing = 0;
        [self registerClass:[JMShowBigPictureCell class] forCellWithReuseIdentifier:showBigPictureCellID];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.iconArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JMShowBigPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:showBigPictureCellID forIndexPath:indexPath];
    cell.bigPictureView.currentRect = self.currentRect;
    if ([self.iconArray[indexPath.row] isKindOfClass:[NSString class]]) {
        [cell.bigPictureView setImageWithURL:self.iconArray[indexPath.row] placeholderImage:self.thumbIconArray[indexPath.row]];
    }else{
        cell.bigPictureView.imageView.image = self.iconArray[indexPath.row];
    }
    __weak __typeof(cell)weakCell = cell;
    cell.singleTapGestureBlock = ^(CGRect rect){
        [self.indexWindow resignKeyWindow];
        [self.window makeKeyAndVisible];
        self.indexWindow.hidden = YES;
        self.needAnimate = YES;
        self.indexWindow = nil;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        self.backgroundColor = [UIColor clearColor];
        weakCell.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.25 animations:^{
            _indexLabel.hidden = YES;
            
            weakCell.bigPictureView.imageContainerView.frame = self.currentRect;
            weakCell.bigPictureView.imageView.yy_width = self.currentRect.size.width;
            weakCell.bigPictureView.imageView.yy_height = self.currentRect.size.height;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[JMShowBigPictureCell class]]) {
        [(JMShowBigPictureCell *)cell recoverSubviews:_needAnimate];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[JMShowBigPictureCell class]]) {
        
        [(JMShowBigPictureCell *)cell recoverSubviews:_needAnimate];
    }
}

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.indexWindow.hidden = NO;
    if (_indexLabel) {
        self.needAnimate = NO;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    JMShowBigPictureCell *cell = [self visibleCells][0];
    CGRect rect = [cell convertRect:[cell convertRect:cell.frame fromView:self] toView:[UIApplication sharedApplication].keyWindow];
    
    if (rect.origin.x == -10) {
        self.index = [self indexPathForCell:cell].row;
    }else{
        
        self.index = [self indexPathForCell:[self visibleCells][1]].row;
    }
    self.indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.index+1, _iconArray.count];
    self.currentRect = CGRectFromString(self.rectArray[self.index]);
    [self performSelector:@selector(hideIndex) withObject:nil afterDelay:1];
}
- (void)hideIndex{
    self.indexWindow.hidden = YES;
}
@end
