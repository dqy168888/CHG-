//
//  CHGTopicPictureView.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/16.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTopicPictureView.h"
#import <DALabeledCircularProgressView.h>
#import <UIImageView+WebCache.h>
#import "CHGTopic.h"

@interface CHGTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (nonatomic, strong) IBOutlet DALabeledCircularProgressView *labeledCircularProgress;
@end
@implementation CHGTopicPictureView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(CHGTopic *)topic
{
    CHGWeakSelf;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) { // 下载时
        
        // 每下载一点图片数据，就会调用一次这个block
        weakSelf.labeledCircularProgress.hidden = NO;
        // 设置圆角
        weakSelf.labeledCircularProgress.roundedCorners = 5;
        // 下载进度
        weakSelf.labeledCircularProgress.progress = 1.0 * receivedSize / expectedSize;
        
        weakSelf.labeledCircularProgress.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.labeledCircularProgress.progress * 100];
        
        weakSelf.labeledCircularProgress.progressLabel.textColor = [UIColor whiteColor];
        
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
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = NO;
    }
}

@end
