//
//  CHGRecommendCategory.h
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/6.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHGRecommendCategory : NSObject

/*
"id": "9",
"name": "电台",
"count": "78"
*/

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *count;

@end
