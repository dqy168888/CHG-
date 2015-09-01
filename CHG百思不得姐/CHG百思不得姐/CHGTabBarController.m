//
//  CHGTabBarController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGTabBarController.h"

@interface CHGTabBarController ()

@end

@implementation CHGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 统一设置所有UITabBarItem的文字属性
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttr[NSForegroundColorAttributeName]  = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = normalAttr[NSFontAttributeName];
    normalAttr[NSForegroundColorAttributeName]  = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];

    // 创建控制器
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.tabBarItem.title = @"精华";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    vc1.view.backgroundColor = [UIColor redColor];
    // 给CHGTabBarController添加子控制器
    [self addChildViewController:vc1];
    
    // 创建控制器
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    vc2.view.backgroundColor = [UIColor greenColor];
    // 给CHGTabBarController添加子控制器
    [self addChildViewController:vc2];
    
    // 创建控制器
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    vc3.view.backgroundColor = [UIColor blueColor];
    // 给CHGTabBarController添加子控制器
    [self addChildViewController:vc3];
    
    // 创建控制器
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.tabBarItem.title = @"我的";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc4.view.backgroundColor = [UIColor grayColor];
    // 给CHGTabBarController添加子控制器
    [self addChildViewController:vc4];

}


@end
