//
//  CHGTagViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  推荐标签

#import "CHGTagViewController.h"
#import "CHGTag.h"
#import "CHGTagViewCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>

@interface CHGTagViewController ()

// tag模型数组
@property (nonatomic, strong) NSArray *tags;
@end

@implementation CHGTagViewController

- (NSArray *)tags
{
    if (_tags == nil) {
        _tags = [NSArray array];
    }
    return _tags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.navigationItem.title = @"推荐标签";
    
    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
    
    self.tableView.rowHeight = 70;
    
    // 去掉系统自带的下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGTagViewCell class]) bundle:nil] forCellReuseIdentifier:@"tagcell"];
    
    // 加载标签数据
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // responseObject：字典数组
        // self.tags：模型数组
        // responseObject -> self.tags
        self.tags = [CHGTag objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHGTagViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagcell"];
    
    cell.Tag = self.tags[indexPath.row];
    
    return cell;
}


@end
