//
//  CHGTagCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/14.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  发帖的cell

#import "CHGTopicCell.h"
#import "CHGTopic.h"

@interface CHGTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end
@implementation CHGTopicCell

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
        CHGLogFunc;
    }]];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        CHGLogFunc;
    }]];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        CHGLogFunc;
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


@end
