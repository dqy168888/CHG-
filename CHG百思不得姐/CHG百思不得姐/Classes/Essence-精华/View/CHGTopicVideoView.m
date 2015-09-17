//
//  CHGTopicVideoView.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/17.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  cell中间显示视频


#import "CHGTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "CHGTopic.h"

@interface CHGTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end
@implementation CHGTopicVideoView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(CHGTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.voicetime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
