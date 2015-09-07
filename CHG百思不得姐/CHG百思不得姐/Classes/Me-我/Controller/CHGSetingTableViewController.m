//
//  CHGSetingTableViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGSetingTableViewController.h"
#import "CHGClearCacheCell.h"

@interface CHGSetingTableViewController ()<UITableViewDelegate>

@end

@implementation CHGSetingTableViewController

static NSString * const clearCell = @"clearCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";

    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
    
    // 设置内边距(-25代表：所有内容往上移动25)
    self.tableView.contentInset = UIEdgeInsetsMake(CHGCommonMargin - 35, 0, 0, 0);
    
    // 注册cell
    [self.tableView registerClass:[CHGClearCacheCell class] forCellReuseIdentifier:clearCell];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CHGClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:clearCell];
    
    return cell;
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CHGClearCacheCell *cell = (CHGClearCacheCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    // 清除缓存
    [cell clearCache];
}
@end
