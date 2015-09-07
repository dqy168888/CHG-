//
//  CHGClearCacheCell.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/7.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGClearCacheCell.h"
#import <SVProgressHUD.h>

/** 缓存路径 */
#define CHGCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"]

static NSString * const CHGDefaultText = @"清除缓存";


@implementation CHGClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CHGLog(@"%@",CHGCacheFile);
        
        self.textLabel.text = CHGDefaultText;
        
        // 计算前禁止用户点击cell
        self.userInteractionEnabled = NO;
        
        // 右边显示圈圈
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;

        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
            
            // 子线程计算缓存大小
            NSInteger size = CHGCacheFile.fileSize;
            CGFloat unit = 1000.0;
            NSString *sizeText = nil;
            if (size >= unit * unit * unit) { // >= 1GB
                sizeText = [NSString stringWithFormat:@"%.1fGB", size / unit / unit / unit];
            } else if (size >= unit * unit) { // >= 1MB
                sizeText = [NSString stringWithFormat:@"%.1fMB", size / unit / unit];
            } else if (size >= unit) { // >= 1KB
                sizeText = [NSString stringWithFormat:@"%.1fKB", size / unit];
            } else { // >= 0B
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            NSString *text = [NSString stringWithFormat:@"%@(%@)", CHGDefaultText, sizeText];
            
            // 主线程显示UI
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.textLabel.text = text;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.accessoryView = nil;
                // 允许交互
                self.userInteractionEnabled = YES;
            }];
            
        }];
    }
    
    return self;
}

- (void)clearCache
{
    [SVProgressHUD showInfoWithStatus:@"正在清除缓存" maskType:SVProgressHUDMaskTypeBlack];
    // 子线程删除缓存文件夹
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        });
        
        [[NSFileManager defaultManager] removeItemAtPath:CHGCacheFile error:nil];
        
        
        // 主线程显示UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
            self.textLabel.text = CHGDefaultText;
            
            // 禁止点击事件
            self.userInteractionEnabled = NO;
        }];
    }];
}


@end
