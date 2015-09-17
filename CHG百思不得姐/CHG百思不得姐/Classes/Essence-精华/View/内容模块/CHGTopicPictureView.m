//
//  CHGTopicPictureView.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/16.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  cell中间显示图片

#import "CHGTopicPictureView.h"
#import <DALabeledCircularProgressView.h>
#import <UIImageView+WebCache.h>
#import "CHGTopic.h"
#import "CHGSeeBigPictureViewController.h"


@interface CHGTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (nonatomic, weak) IBOutlet DALabeledCircularProgressView *labeledCircularProgress;
@end
@implementation CHGTopicPictureView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 设置圆角
    self.labeledCircularProgress.roundedCorners = 5;
    
    self.labeledCircularProgress.progressLabel.textColor = [UIColor whiteColor];
    
    // 开放交互能力
    self.imageView.userInteractionEnabled = YES;
    // 添加点击手势
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
}

- (void)imageClick
{
    // 图片没有下载好之前不能跳转
    if (self.imageView.image == nil) return;
    
    CHGSeeBigPictureViewController *seeBigImageVC = [[CHGSeeBigPictureViewController alloc] init];
    seeBigImageVC.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigImageVC animated:YES completion:nil];
}

- (void)setTopic:(CHGTopic *)topic
{
     _topic = topic;
    CHGWeakSelf;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) { // 下载时
        // 每下载一点图片数据，就会调用一次这个block
        self.labeledCircularProgress.hidden = NO;
        // 下载进度
        weakSelf.labeledCircularProgress.progress = 1.0 * receivedSize / expectedSize;
        
        weakSelf.labeledCircularProgress.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.labeledCircularProgress.progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 下载完毕
        weakSelf.labeledCircularProgress.hidden = YES;
    }];
    
    // 设置gif标志
    self.gifImageView.hidden = !topic.is_gif;
    
    self.seeBigPictureButton.hidden = !topic.isBigPicture;
    if (topic.bigPicture) {    // 设置大图显示模式
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else
    {   // 不是大图的情况
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
