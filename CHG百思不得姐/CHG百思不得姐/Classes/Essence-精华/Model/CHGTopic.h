//
//  CHGTopic.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/14.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /** 图片 */
    CHGTopicTypePicture = 10,
    
    /** 段子(文字) */
    CHGTopicTypeWord = 29,
    
    /** 声音 */
    CHGTopicTypeVoice = 31,
    
    /** 视频 */
    CHGTopicTypeVideo = 41
} CHGTopicType;

@interface CHGTopic : NSObject
// 用户 -- 发帖者
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 类型 */
@property (nonatomic, assign) CHGTopicType type;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 中图 */
@property (nonatomic, copy) NSString *image2;

/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;

/***** 额外增加的属性 ******/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;
/** 是否大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;


@end
