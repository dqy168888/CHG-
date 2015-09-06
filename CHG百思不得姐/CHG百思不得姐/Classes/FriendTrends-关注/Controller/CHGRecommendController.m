//
//  CHGRecommendController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGRecommendController.h"
#import <AFNetworking.h>


@interface CHGRecommendController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic, strong) NSArray *Categorys;

@property (weak, nonatomic) IBOutlet UITableView *CategoryTableView;

@end

@implementation CHGRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"推荐关注";
    // 设置背景色
    self.view.backgroundColor = CHGGlobalBg;
    
    
    
    // 请求数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask * task, NSError * responseObject) {
        
    }];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chgCell"];
    
    cell.textLabel.text = @"111";
    
    return cell;
    
}

#pragma mark < UITableViewDelegate >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

@end
