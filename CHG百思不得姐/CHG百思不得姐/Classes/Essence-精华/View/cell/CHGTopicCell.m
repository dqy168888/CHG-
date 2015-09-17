//
//  CHGTagCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/14.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  发帖的cell

#import "CHGTopicCell.h"
#import "CHGTopic.h"
#import "CHGTopicPictureView.h"
#import "CHGTopicVideoView.h"
#import "CHGTopicVoiceView.h"
#import "CHGComment.h"
#import "CHGUser.h"

@interface CHGTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 图片 */
@property (nonatomic, weak) CHGTopicPictureView *pictureView;
/** 视频 */
@property (nonatomic, weak) CHGTopicVideoView *videoView;
/** 声音 */
@property (nonatomic, weak) CHGTopicVoiceView *voiceView;
/** 最热评论view */
@property (weak, nonatomic) IBOutlet UIView *hotView;
/** 最热评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation CHGTopicCell

- (CHGTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        CHGTopicPictureView *pictureView = [CHGTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (CHGTopicVideoView *)videoView
{
    if (_videoView == nil) {
        CHGTopicVideoView *videoView = [CHGTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (CHGTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        CHGTopicVoiceView *voiceView = [CHGTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}


- (void)awakeFromNib
{
    // 设置cell的背景图片
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(CHGTopic *)topic
{
    _topic = topic;
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createAtLabel.text = topic.created_at;
    self.text_Label.text = topic.text;
    
    // 设置底部工具条的数字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 根据帖子的类型决定中间的内容
    if (topic.type == CHGTopicTypePicture) { // 图片
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
        
    } else if (topic.type == CHGTopicTypeVoice) { // 声音
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentFrame;
        self.voiceView.topic = topic;
        
    } else if (topic.type == CHGTopicTypeVideo) { // 视频
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentFrame;
        self.videoView.topic = topic;

    } else if (topic.type == CHGTopicTypeWord) { // 文字
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    CHGComment *cmt = topic.top_cmt.firstObject;
    if (cmt) {
        NSString *username = cmt.user.username;
        NSString *content = cmt.content;
        self.hotView.hidden = NO;
        self.contentLabel.text = [NSString stringWithFormat:@"%@ : %@",username,content];
    }else
    {
        self.hotView.hidden = YES;
    }
    
}

/**
 * 设置工具条按钮的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= CHGCommonMargin;
    frame.origin.y += CHGCommonMargin;
    [super setFrame:frame];
}

- (IBAction)moreClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }]];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }]];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


@end
