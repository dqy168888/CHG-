//
//  CHGRecommendController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGRecommendController.h"
#import <AFNetworking.h>
#import "CHGRecommendCategoryCell.h"
#import "CHGUserCell.h"
#import "CHGChiBaoZiFooter.h"
#import "CHGChiBaoZiHeader.h"
#import <SVProgressHUD.h>
#import "CHGRecommendCategory.h"
#import <MJExtension.h>

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
    [SVProgressHUD show];
    
    // 请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.Categorys = [CHGRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [SVProgressHUD dismiss];
        [self.CategoryTableView reloadData];
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
}

- (void)setupRefresh
{
    self.UserTableView.header = [CHGChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
}

- (void)loadNewUser
{
    
}

- (void)dealloc
{
    [self.manager invalidateSessionCancelingTasks:YES];
}



#pragma mark  < UITableViewDataSource >
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.CategoryTableView) {
        return self.Categorys.count;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.CategoryTableView) { // 左边的类别表格 👈 ←
        CHGRecommendCategoryCell *cell =  [tableView dequeueReusableCellWithIdentifier:CategoryID];
        cell.category = self.Categorys[indexPath.row];
        
        return cell;
    } else { // 右边的用户表格 👉 →
        CHGUserCell *cell = [tableView dequeueReusableCellWithIdentifier:UserID];
        cell.textLabel.text = [NSString stringWithFormat:@"%zd---", indexPath.row];
        return cell;
    }
}


#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.CategoryTableView) { // 左边的类别表格 👈 ←
        CHGLog(@"点击了👈←的%zd行", indexPath.row);
    } else { // 右边的用户表格 👉 →
        CHGLog(@"点击了👉→的%zd行", indexPath.row);
    }
}

@end
