//
//  CHGExtensionConfig.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGExtensionConfig.h"
#import <MJExtension.h>
#import "CHGTopic.h"

#import "CHGUser.h"
#import "CHGComment.h"

@implementation CHGExtensionConfig
+ (void)load
{
    [CHGTopic setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 @"topComment" : @"top_cmt[0]"
                 };
    }];
    
    [CHGTopic setupObjectClassInArray:^NSDictionary *{
        // 数组名 : 模型名
        return @{@"user" : [CHGUser class]};
        //    return @{@"top_cmt" : @"CHGComment"};
    }];

}

@end
