//
//  CHGCommentViewController2.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGCommentViewController2.h"
#import "CHGTopic.h"
#import "CHGTopicCell.h"
#import "CHGCommentCell.h"
#import "CHGChiBaoZiFooter.h"
#import "CHGChiBaoZiHeader.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "CHGCommentHeaderView.h"
#import "CHGUser.h"

@interface CHGCommentViewController2 ()<UITableViewDelegate, UITableViewDataSource>
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

/** 写方法声明的目的是为了使用点语法提示 */
- (CHGComment *)selectedComment;

@end

@implementation CHGCommentViewController2


#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTable];
    
    [self setupRefresh];
    
    
}

- (void)setupTable
{
    self.tableView.backgroundColor = CHGGlobalBg;
    
    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    
    UIView *header = [[UIView alloc] init];
    header.height = cell.height + CHGCommonMargin ;
    [header addSubview:cell];
    
    self.tableView.tableHeaderView = header;
}

- (void)setupNav
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
        
//        CHGWriteToPlist(responseObject, @"comment");
        
        // 字典数组 -> 模型数组
        weakSelf.hotComments = [CHGComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        weakSelf.latestComments = [CHGComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 页码
        self.page = 1;
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
//        });
        
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



#pragma mark - 监听
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 工具条平移的距离 == 屏幕高度 - 键盘最终的Y值
    self.bottomSpace.constant = CHGScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotComments.count){
    
        return self.hotComments.count;
    }
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Comment"];
    
    // 获得对应的评论数据
    NSArray *comments = self.latestComments;
    if (indexPath.section == 0 && self.hotComments.count){
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

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) return @"最热评论";
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CHGCommentHeaderView *header = [[CHGCommentHeaderView alloc] initWithReuseIdentifier:@"header"];
    
    if (section == 0 && self.hotComments.count ) {
        header.text = @"最热评论";
    } else
    {
        header.text = @"最新评论";
    }
    
    return header;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    // 设置菜单内容
    menu.menuItems = @[
                       [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(warn:)],
                       ];
    
    // 显示位置
    CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, 1);
    [menu setTargetRect:rect inView:cell];
    // 显示出来
    [menu setMenuVisible:YES animated:YES];
}

- (CHGComment *)selectedComment
{
    NSIndexPath *indexpath = self.tableView.indexPathForSelectedRow;
    NSInteger row = indexpath.row;
    
    NSArray *comments = self.latestComments;
    if (indexpath.section == 0 && self.hotComments.count) {
        comments = self.hotComments;
    }

    return comments[row];
}

#pragma mark - UIMenuController处理
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (!self.isFirstResponder) { // 如果控制器不是第一响应者时（文本框弹出键盘时，文本框才是第一响应者）
        if (action == @selector(ding:)
            || action == @selector(reply:)
            || action == @selector(warn:)) return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)ding:(UIMenuController *)menu
{
    CHGLog(@"ding - %@ %@",
           self.selectedComment.user.username,
           self.selectedComment.content);
}

- (void)reply:(UIMenuController *)menu
{
    CHGLog(@"reply - %@ %@",
           self.selectedComment.user.username,
           self.selectedComment.content);
}

- (void)warn:(UIMenuController *)menu
{
    CHGLog(@"warn - %@ %@",
           self.selectedComment.user.username,
           self.selectedComment.content);
}
@end
