//
//  CHGRecommendCategory.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/6.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHGRecommendCategory : NSObject

@property (nonatomic, strong) NSString *ID;
/** 名字 */
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *count;

/** 这个频道对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
/** 该频道用户总数 */
@property (nonatomic, assign) NSInteger total;

@end
