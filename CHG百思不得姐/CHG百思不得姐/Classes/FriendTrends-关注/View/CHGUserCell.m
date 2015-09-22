//
//  CHGUserCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/20.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGUserCell.h"
#import "CHGFollowUser.h"

@interface CHGUserCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
/** 粉丝数 */
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation CHGUserCell

- (void)setUser:(CHGFollowUser *)user
{
    _user = user;
    
    [self.headerImageView setHeader:user.header];

    self.screenNameLabel.text = user.screen_name;
    
    if (user.fans_count >= 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    } else {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    }
    
}

@end
