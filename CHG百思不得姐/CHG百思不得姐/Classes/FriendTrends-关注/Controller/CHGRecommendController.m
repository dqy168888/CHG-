//
//  CHGRecommendController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  推荐关注

#import "CHGRecommendController.h"
#import <AFNetworking.h>
#import "CHGRecommendCategoryCell.h"
#import "CHGUserCell.h"
#import "CHGChiBaoZiFooter.h"
#import "CHGChiBaoZiHeader.h"
#import <SVProgressHUD.h>
#import "CHGRecommendCategory.h"
#import <MJExtension.h>
#import "CHGFollowUser.h"

#define CHGSelectedCategory self.Categorys[self.CategoryTableView.indexPathForSelectedRow.row]

@interface CHGRecommendController ()<UITableViewDataSource , UITableViewDelegate>
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;
/** 左边数据模型 */
@property (nonatomic, strong) NSArray *Categorys;

/** 左边的tableView */
@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;
/** 右边的tableView */
@property (weak, nonatomic) IBOutlet UITableView *UserTableView;

@end

@implementation CHGRecommendController

#pragma mark 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)loadCategories
{
//    [SVProgressHUD show];
    
    // 请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    CHGWeakSelf;
    [weakSelf.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        weakSelf.Categorys = [CHGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [SVProgressHUD dismiss];
        
        [weakSelf.CategoryTableView reloadData];
        
        [weakSelf.CategoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [weakSelf.UserTableView.header beginRefreshing];
    } failure:^(NSURLSessionDataTask * task, NSError * responseObject) {
        
        [SVProgressHUD dismiss];
        
    }];
    
}

static NSString * const CategoryID = @"Category";
static NSString * const UserID = @"User";

#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTable];
    
    [self setupRefresh];

    [self loadCategories];
}

- (void)setupTable
{
    self.navigationItem.title = @"推荐关注";
    // 设置背景色
    self.view.backgroundColor = CHGGlobalBg;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(CHGNavBarMaxY, 0, 0, 0);
    
    [self.CategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGRecommendCategoryCell class])  bundle:nil] forCellReuseIdentifier:CategoryID];
    self.CategoryTableView.contentInset = inset;
    self.CategoryTableView.scrollIndicatorInsets = inset;
    self.CategoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.UserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGUserCell class])  bundle:nil] forCellReuseIdentifier:UserID];
    self.UserTableView.contentInset = inset;
    self.UserTableView.scrollIndicatorInsets = inset;
    self.UserTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.UserTableView.rowHeight = 70;
}

- (void)setupRefresh
{
    self.UserTableView.header = [CHGChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    
    self.UserTableView.footer = [CHGChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
}

- (void)loadNewUser
{
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 取出当前选中的频道模型
    CHGRecommendCategory *rc = CHGSelectedCategory;
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = rc.ID;
    
    CHGWeakSelf;
    [self.manager GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 重置页码为1
        rc.currentPage = 1;
        
        // 存储总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 服务器返回的JSON数据
        rc.users = [CHGFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [weakSelf.UserTableView reloadData];
        
        
        // 结束刷新
        [weakSelf.UserTableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        [weakSelf.UserTableView.header endRefreshing];
    }];
}

- (void)loadMoreUser
{
    // 取消之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 取出当前选中的频道模型
    CHGRecommendCategory *rc = CHGSelectedCategory;
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = rc.ID;
    // 页码
    NSInteger page = rc.currentPage + 1;
    params[@"page"] = @(page);
    
    CHGWeakSelf;
    [self.manager GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        CHGWriteToPlist(responseObject, @"user");
        // 设置当前的最新页码
        rc.currentPage = page;
        
        rc.total = [responseObject[@"total"] integerValue];
        
        // 服务器返回的JSON数据
        NSArray *moreUser = [CHGFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [rc.users addObjectsFromArray:moreUser];
        
        // 刷新表格
        [weakSelf.UserTableView reloadData];
        
        if (rc.users.count >= rc.total) {
            weakSelf.UserTableView.footer.hidden = YES;
        }else
        {
            // 结束刷新
            [weakSelf.UserTableView.footer endRefreshing];
        
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        [weakSelf.UserTableView.footer endRefreshing];
    }];

}

- (void)dealloc
{
    [SVProgressHUD dismiss];
    [self.manager invalidateSessionCancelingTasks:YES];
}



#pragma mark  < UITableViewDataSource >
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.CategoryTableView) {
        return self.Categorys.count;
    }
    // 取出当前选中的频道模型
    CHGRecommendCategory *rc = CHGSelectedCategory;
    
    return rc.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.CategoryTableView) { // 左边的类别表格 👈 ←
        CHGRecommendCategoryCell *cell =  [tableView dequeueReusableCellWithIdentifier:CategoryID];
        cell.category = self.Categorys[indexPath.row];
        
        return cell;
    } else { // 右边的用户表格 👉 →
        CHGUserCell *cell = [tableView dequeueReusableCellWithIdentifier:UserID];
        // 取出当前选中的频道模型
        CHGRecommendCategory *rc = CHGSelectedCategory;
        cell.user = rc.users[indexPath.row];
        return cell;
    }
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.CategoryTableView) { // 点击了左边的频道
        
        // 刷新右边的用户表格 👉 →
        // （MJRefresh的默认做法：表格有数据，就会自动显示footer，表格没有数据，就会自动隐藏footer）
        [self.UserTableView reloadData];
        
        CHGRecommendCategory *rc = CHGSelectedCategory;
        
        if (rc.users.count == 0) { // 没有加载过用户数据
            [self.UserTableView.header beginRefreshing];
        }
        
        // 判断footer是否应该显示
        if (rc.users.count >= rc.total ) { //
            self.UserTableView.footer.hidden = YES;
        }
        
    }else
    {   // 右边的用户表格 👉 →
        CHGLog(@"点击了👉→的%zd行", indexPath.row);
        
    }
    
}

@end
