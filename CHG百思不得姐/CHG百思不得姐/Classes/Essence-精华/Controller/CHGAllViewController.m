//
//  CHGAllViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/14.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGAllViewController.h"
#import "CHGTopic.h"
#import "CHGTopicCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "CHGChiBaoZiFooter.h"
#import "CHGChiBaoZiHeader.h"
/*
 1.要想让一个scrollView的内容能够穿透整个屏幕
 1> 让scrollView的frame占据整个屏幕
 
 2.要想让用户能看清楚所有的内容，不被导航栏和tabbar挡住
 1> 设置scrollView的contentInset属性
 */
@interface CHGAllViewController ()
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation CHGAllViewController

static NSString * const CHGTopicCellID = @"Topic";
#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTab];
   
    [self setupRefresh];
}


- (void)setupTab
{
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(CHGNavBarMaxY + CHGTitlesViewH, 0, CHGTabBarH, 0);
    self.tableView.backgroundColor = CHGGlobalBg;
    // 设置滚动条的范围
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGTopicCell class]) bundle:nil] forCellReuseIdentifier:CHGTopicCellID];
    
    self.tableView.rowHeight = 200;
    
}

- (void)setupRefresh
{
    self.tableView.header = [CHGChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [CHGChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)loadNewTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @1;//@"1";
    
    // 发送请求
    CHGWeakSelf;
    [self.manager GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        weakSelf.topics = [CHGTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @1;//@"1";
    params[@"maxtime"] = self.maxtime;
    
    // 发送请求
    CHGWeakSelf;
    [self.manager GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组 -> 模型数组
        NSMutableArray *moretopics = [CHGTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moretopics];
        
        // 存储maxtime
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.footer endRefreshing];
    }];

}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CHGTopicCellID];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

@end
