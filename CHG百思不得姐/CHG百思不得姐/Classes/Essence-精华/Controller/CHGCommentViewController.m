//
//  CHGCommentViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/18.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGCommentViewController.h"
#import "CHGTopicCell.h"
#import "CHGCommentCell.h"
#import "CHGTopic.h"

@interface CHGCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CHGCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGTopicCell class]) bundle:nil] forCellReuseIdentifier:@"Topic"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CHGCommentCell class]) bundle:nil] forCellReuseIdentifier:@"Comment"];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    if (section == 1) return 15;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CHGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Topic"];;
        cell.topic = self.topic;
        return cell;
    }else
    {
        return [tableView dequeueReusableCellWithIdentifier:@"Comment"];
    }
}

#pragma mark <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return self.topic.cellHeight;
    
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if (section == 0) return nil;
    if (section == 1) return @"最热评论";
    return @"最新评论";
}

@end
