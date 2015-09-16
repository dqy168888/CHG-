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

@interface CHGSeeBigPictureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation CHGSeeBigPictureViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    // 将图片写入手机相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加滚动
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, CHGScreenW, CHGScreenH);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
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
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }

}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
