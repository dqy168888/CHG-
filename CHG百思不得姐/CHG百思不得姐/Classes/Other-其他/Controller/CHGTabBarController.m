//
//  CHGTabBarController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTabBarController.h"
#import "CHGEssenceViewController.h"
#import "CHGNewViewController.h"
#import "CHGFriendTrendsViewController.h"
#import "CHGMeViewController.h"
#import "CHGTabBar.h"
#import "CHGNavigationController.h"

@interface CHGTabBarController ()

@end

@implementation CHGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 统一设置所有UITabBarItem的文字属性
    [self setupAttribute];

    // 设置子控制器
    [self setupChildVc];
    
    // 设置tabbar
    [self setupTabBar];
}

- (void)setupChildVc
{
    [self setupChildVc:[[CHGFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[CHGEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[CHGMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    [self setupChildVc:[[CHGNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
}

// 设置子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 将vc包装成CHGNavigationController
    CHGNavigationController *nav = [[CHGNavigationController alloc] initWithRootViewController:vc];
    // 给CHGTabBarController添加子控制器nav
    [self addChildViewController:nav];
}


- (void)setupTabBar
{
    [self setValue:[[CHGTabBar alloc] init] forKeyPath:@"tabBar"];
}


- (void)setupAttribute
{
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttr[NSForegroundColorAttributeName]  = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = normalAttr[NSFontAttributeName];
    normalAttr[NSForegroundColorAttributeName]  = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}



@end
