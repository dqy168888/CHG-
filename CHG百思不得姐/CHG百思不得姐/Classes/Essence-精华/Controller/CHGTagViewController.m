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
#import <SVProgressHUD.h>

@interface CHGTagViewController ()

// tag模型数组
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@end

@implementation CHGTagViewController
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSArray *)tags
{
    if (_tags == nil) {
        _tags = [NSArray array];
    }
    return _tags;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"推荐标签";
    
    [self setTable];
    
    [self loadTags];
}

- (void)setTable
{
    // 设置背景颜色
    self.view.backgroundColor = CHGGlobalBg;
    
    self.tableView.rowHeight = 70;
    
    // 去掉系统自带的下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGTagViewCell class]) bundle:nil] forCellReuseIdentifier:@"tagcell"];
}

- (void)loadTags
{
    // 弹框
    //    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 加载标签数据
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    CHGWeakSelf
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 服务器没有数据（一般不会出现这种情况）
        if (responseObject == nil) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
            return;
        }
        
        // responseObject：字典数组
        // responseObject -> weakSelf.tags
        weakSelf.tags = [CHGTag objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 关闭蒙版
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 如果是取消了任务，就不算请求失败，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        if (error.code == NSURLErrorTimedOut) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据超时，请稍后再试！"];
        } else {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        }
        
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



- (void)dealloc
{
    // 停止请求(取消所有task)
    [self.manager invalidateSessionCancelingTasks:YES];
    
    [SVProgressHUD dismiss];
}

@end
