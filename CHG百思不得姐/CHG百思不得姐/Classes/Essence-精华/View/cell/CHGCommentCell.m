//
//  CHGCommentCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGCommentCell.h"
#import "CHGComment.h"
#import "CHGUser.h"


@interface CHGCommentCell ()
/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 用户性别 */
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 语言按钮 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
/** 评论点赞数 */
@property (weak, nonatomic) IBOutlet UILabel *likeCoutLabel;

@end

@implementation CHGCommentCell

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
}

- (void)setComment:(CHGComment *)comment
{
    _comment = comment;
    
    [self.profileImageView setHeader:comment.user.profile_image];
    self.likeCoutLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    
    if ([comment.user.sex isEqualToString:CHGUserSexMale]) {
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else {
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime]  forState:UIControlStateNormal];
    }else
    {
        self.voiceButton.hidden = YES;
    }
    
    
}

@end
