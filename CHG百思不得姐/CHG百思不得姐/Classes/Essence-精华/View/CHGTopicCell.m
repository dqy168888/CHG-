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


@end
@implementation CHGTopicCell

- (void)setTopic:(CHGTopic *)topic
{
    _topic = topic;
    [self.profileImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createAtLabel.text = topic.created_at;
    
    self.text_Label.text = topic.text;
}

@end
