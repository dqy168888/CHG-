//
//  CHGCommentViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGCommentViewController.h"
#import "CHGTopic.h"
#import "CHGTopicCell.h"
#import "CHGCommentCell.h"
#import "CHGChiBaoZiFooter.h"
#import "CHGChiBaoZiHeader.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CHGCommentHeaderView.h"

@interface CHGCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 暂时存储：最热评论 */
@property (nonatomic, strong) CHGComment *topComment;

/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论（所有的评论数据） */
@property (nonatomic, strong) NSMutableArray *latestComments;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) CHGTopicCell *topCell;

@end

@implementation CHGCommentViewController

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupNav
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupTable
{
    self.tableView.backgroundColor = CHGGlobalBg;
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGTopicCell class]) bundle:nil] forCellReuseIdentifier:@"Topic"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGCommentCell class]) bundle:nil] forCellReuseIdentifier:@"Comment"];
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    // 对传过来的数据进行处理
    if (self.topic.topComment) {
        // 把最热评论存起来
        self.topComment = self.topic.topComment;
        // 清空最热评论模块  （因为这里不需要显示）
        self.topic.cellHeight = 0;
        self.topic.topComment = nil;
    }
    

    CHGTopicCell *cell = [CHGTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, CHGScreenW, self.topic.cellHeight);
    self.topCell = cell;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 恢复帖子的最热评论数据
    if (self.topComment) {
        self.topic.topComment = self.topComment;
        self.topic.cellHeight = 0;
    }
}


- (void)setupRefresh
{
    self.tableView.header = [CHGChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    [self.tableView.header beginRefreshing];
    
    self.tableView.footer = [CHGChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 加载评论数据
- (void)loadNewTopics
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    
    // 发送请求
    CHGWeakSelf;
    [self.manager GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {

        // 字典数组 -> 模型数组
        weakSelf.hotComments = [CHGComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.latestComments = [CHGComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        self.page = 1;
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [weakSelf.tableView.header endRefreshing];
//        });
        
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
    
    // 页码
    NSInteger page = self.page + 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    
    CHGComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    // 发送请求
    CHGWeakSelf;
    [self.manager GET:CHGRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.footer.hidden = YES;
            return;
        }
        
//        CHGWriteToPlist(responseObject, @"newComments");
        
        // 字典数组 -> 模型数组
        NSArray *newComments = [CHGComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments addObjectsFromArray:newComments];
        
        // 页码
        self.page = page;
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // 全部加载完毕
//            [self.tableView.footer noticeNoMoreData];
            self.tableView.footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
}


- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    self.bottomSpace.constant = CHGScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] CGRectValue].origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 3;
    if (self.latestComments.count) return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return 1;
    }else if (section == 1 && self.hotComments.count){
        
        return self.hotComments.count;
    }
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    
        return self.topCell;
    }
    
    CHGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment"];
    // 获得对应的评论数据
    NSArray *comments = self.latestComments;
    if (indexPath.section == 1 && self.hotComments.count){
        comments = self.hotComments;
    }
    // 传递模型给cell
    cell.comment = comments[indexPath.row];
    
    return cell;
}


#pragma mark <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.topic.cellHeight;
    }
    return self.tableView.rowHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if (section == 0) return nil;
    if (section == 1) return @"最热评论";
    return @"最新评论";
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CHGCommentHeaderView *header = [[CHGCommentHeaderView alloc] initWithReuseIdentifier:@"header"];
//    if (section == 0) {
//        
//    }else if (section == 1 && self.hotComments.count ) {
//        header.text = @"最热评论";
//    } else if (section == 2 )
//    {
//        header.text = @"最新评论";
//    }
//    return header;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    CHGCommentHeaderView *header = [[CHGCommentHeaderView alloc] initWithReuseIdentifier:@"header"];
//    if (section == 0) {
//        
//    }else if (section == 1 && self.hotComments.count ) {
//        header.text = @"最热评论";
//    } else if (section == 2 )
//    {
//        header.text = @"最新评论";
//    }
//    return header;
//}

@end
