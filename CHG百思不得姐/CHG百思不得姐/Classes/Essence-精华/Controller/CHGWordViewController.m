//
//  CHGWordViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/14.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGWordViewController.h"

@interface CHGWordViewController ()

@end

@implementation CHGWordViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(CHGNavBarMaxY + CHGTitlesViewH, 0, CHGTabBarH, 0);
    self.tableView.backgroundColor = CHGGlobalBg;
    // 设置滚动条的范围
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd -- ", self.title, indexPath.row];
    
    return cell;
}
@end
