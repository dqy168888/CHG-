//
//  CHGSeeBigPictureViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/16.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "CHGTopic.h"
#import <SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface CHGSeeBigPictureViewController ()<UIScrollViewDelegate>
/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;
/** 图片 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 相册库 */
@property (nonatomic, strong) ALAssetsLibrary *library;
@end

@implementation CHGSeeBigPictureViewController

- (ALAssetsLibrary *)library
{
    if (!_library) {
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
    // 开放交互能力
    self.scrollView.userInteractionEnabled = YES;
    // 添加点击手势
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
}

- (void)setupScrollView
{
    // 添加滚动
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, CHGScreenW, CHGScreenH);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    imageView.x = 0;
    imageView.width = CHGScreenW;
    imageView.height = (self.topic.height / self.topic.width) * imageView.width ;
    // 设置图片的frame
    if (imageView.height >= CHGScreenH) {
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }else
    {
        imageView.centerY = CHGScreenH * 0.5;
    }
    
    // 伸缩
    CGFloat maxScale = self.topic.height  / imageView.height;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.minimumZoomScale = 1 / maxScale;
    }
    
}

static NSString * const CHGGroupNameKey = @"CHGGroupNameKey";
static NSString * const CHGDefaultGroupName = @"百思不得姐";

- (NSString *)groupName
{
    // 先从沙盒中取得名字
    NSString *groupName = [[NSUserDefaults standardUserDefaults] stringForKey:CHGGroupNameKey];
    if (groupName == nil) { // 沙盒中没有存储任何文件夹的名字
        groupName = CHGDefaultGroupName;
        
        // 存储名字到沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:CHGGroupNameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return groupName;
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    [super touchesBegan:touches withEvent:event];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (IBAction)save:(id)sender {
    
    // 获得相册名
    __block NSString *groupName = [self groupName];
    
    // 图片库
    __weak ALAssetsLibrary *weakLibrary = self.library;
    
    CHGWeakSelf;
    // 创建文件夹
    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
        if (group) { // 新创建的文件夹
            // 添加图片到文件夹中
            [weakSelf addImageToGroup:group];
        } else { // 文件夹已经存在
            [weakLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
                if ([name isEqualToString:groupName]) { // 是自己创建的文件夹
                    // 添加图片到文件夹中
                    [weakSelf addImageToGroup:group];
                    
                    *stop = YES; // 停止遍历
                } else if ([name isEqualToString:@"Camera Roll"]) {
                    // 文件夹被用户强制删除了
                    groupName = [groupName stringByAppendingString:@" "];
                    // 存储新的名字
                    [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:CHGGroupNameKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    // 创建新的文件夹
                    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
                        // 添加图片到文件夹中
                        [weakSelf addImageToGroup:group];
                    } failureBlock:nil];
                }
            } failureBlock:nil];
        }
    } failureBlock:nil];
}

/**
 * 添加一张图片到某个文件夹中
 */
- (void)addImageToGroup:(ALAssetsGroup *)group
{
    __weak ALAssetsLibrary *weakLibrary = self.library;
    // 需要保存的图片
    CGImageRef image = self.imageView.image.CGImage;
    
    // 添加图片到【相机胶卷】
    [weakLibrary writeImageToSavedPhotosAlbum:image metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            // 添加一张图片到自定义的文件夹中
            [group addAsset:asset];
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        } failureBlock:nil];
    }];
}

// 写入手机相册方法的回调  必须要能接受三个参数 
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


@end
