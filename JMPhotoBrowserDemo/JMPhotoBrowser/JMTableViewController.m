//
//  JMTableViewController.m
//  JMPhotoBrowser
//
//  Created by LiuQingying on 2017/8/8.
//  Copyright © 2017年 LiuQingying. All rights reserved.
//

#import "JMTableViewController.h"
#import "JMTableViewCell.h"
#import "JMShowBigPictureView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface JMTableViewController ()

@property (strong, nonatomic) NSArray *dataSourceArr;

@end
static NSString *const JMTableViewCellID = @"JMTableViewCellID";
@implementation JMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JMTableViewCell class]) bundle:nil] forCellReuseIdentifier:JMTableViewCellID];
    
    self.dataSourceArr = @[@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-744_w828.000000_h1104.000000.jpg",@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-479_w828.000000_h620.000000.jpg",@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-744_w828.000000_h1104.000000.jpg",@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-110_w828.000000_h620.000000.jpg",@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-479_w828.000000_h620.000000.jpg",@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-744_w828.000000_h1104.000000.jpg",@"http://yunyue-img.oss-cn-shanghai.aliyuncs.com/temp/2017-08-08-14-33-34-890_w828.000000_h1104.000000.jpg"];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:JMTableViewCellID forIndexPath:indexPath];
    [cell setImageView:self.dataSourceArr];
    __weak typeof(cell) weakCell = cell;
    cell.clickPictureView = ^(NSArray *imagesArr,NSInteger tag){
        NSMutableArray *rectArr = [NSMutableArray arrayWithCapacity:9];
        NSMutableArray *thumbIconArr = [NSMutableArray arrayWithCapacity:9];
        
        for (UIImageView *imageView in imagesArr) {
            if (imageView.image) {
                [thumbIconArr addObject:imageView.image];
            }
            NSLog(@"-----%@",NSStringFromCGRect(imageView.frame));
            UIWindow* window = [UIApplication sharedApplication].keyWindow;
            CGRect rect1 = [imageView convertRect:imageView.frame fromView:weakCell];
            CGRect rect2 = [imageView convertRect:rect1 toView:window];
            [rectArr addObject:NSStringFromCGRect(rect2)];
        
        }
            
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        JMShowBigPictureView *showBigPictureView = [[JMShowBigPictureView alloc] initWithFrame:CGRectMake(-10, 0, kScreenWidth+20, kScreenHeight) collectionViewLayout:layout];
        showBigPictureView.iconArray = thumbIconArr;
        showBigPictureView.thumbIconArray = thumbIconArr;
        showBigPictureView.rectArray = rectArr;
        showBigPictureView.index = tag;
        showBigPictureView.currentRect = CGRectFromString(rectArr[tag]);
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        [[UIApplication sharedApplication].keyWindow addSubview:showBigPictureView];

    };
    return cell;
}

@end
