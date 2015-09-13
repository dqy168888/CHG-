//
//  CHGEssenceViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/1.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//  精华

#import "CHGEssenceViewController.h"
#import "CHGTagViewController.h"
#import "CHGTitleButton.h"
#import "CHGAllViewController.h"
#import "CHGVideoViewController.h"
#import "CHGVoiceViewController.h"
#import "CHGPictureViewController.h"
#import "CHGWordViewController.h"

@interface CHGEssenceViewController ()

@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 当前被选中的按钮 */
@property (nonatomic, weak) CHGTitleButton *selectedTitleButton;
/** 标题栏底部的指示器 */
@property (nonatomic, weak) UIView *titleBottomView;
/** 存放所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *titleButtons;

@end

@implementation CHGEssenceViewController

#pragma mark lazy
- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

#pragma mark 初始化设置
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildVcs];

    [self setupScrollView];
    
    [self setupTitlesView];
}

- (void)setupChildVcs
{
    CHGAllViewController *all = [[CHGAllViewController alloc] init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    CHGVideoViewController *video = [[CHGVideoViewController alloc] init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    CHGVoiceViewController *voice = [[CHGVoiceViewController alloc] init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    CHGPictureViewController *picture = [[CHGPictureViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    CHGWordViewController *word = [[CHGWordViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
}

- (void)setupTitlesView
{
    // 创建titlesView
    UIView *titlesView = [[UIView alloc] init];
    titlesView.frame = CGRectMake(0, CHGNavBarMaxY, self.view.width, 35);
    titlesView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标签栏内部的标签按钮
    NSUInteger count = self.childViewControllers.count;
    CGFloat titleButtonW = self.view.width / count;
    CGFloat titleButtonH = titlesView.height;
    for (int i = 0; i < count; ++i) {
        // 创建标签按钮
        CHGTitleButton *titleButton = [CHGTitleButton buttonWithType:UIButtonTypeCustom];
//        titleButton.backgroundColor = CHGRandomColor;
//        titleButton.titleLabel.backgroundColor = CHGRandomColor;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        // 设置文字
        NSString *title = [self.childViewControllers[i] title];
        [titleButton setTitle:title forState:UIControlStateNormal];
        
        // 设置标签按钮frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
    // 标签栏底部的指示器控件
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.height = 1;
    titleBottomView.y = titlesView.height - titleBottomView.height;
    
//    titleBottomView.backgroundColor = [UIColor redColor];
    titleBottomView.backgroundColor = [self.titleButtons.lastObject titleColorForState:UIControlStateSelected];
    
    [titlesView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    // 默认选中第一个标签
    CHGTitleButton *firstTitleButton = self.titleButtons.firstObject;
    // 系统还没来得及渲染按钮，这时拿不到按钮内部label的宽度，所以提前计算下
    [firstTitleButton.titleLabel sizeToFit];
    // 先设置宽度 后设置x 如果顺序相反，会出现bug（进入界面时x位置不对）
    titleBottomView.width = firstTitleButton.titleLabel.width;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleClick:firstTitleButton];
}

- (void)setupScrollView
{
    // 不要让系统自动设置scrollView的偏移量（顶部导航栏和底部tabbar）
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = CHGGlobalBg;
    
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}


#pragma mark 监听
- (void)titleClick:(CHGTitleButton *)titleButton
{
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
    
    // 滚动到指定的控制器

    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width * [self.titleButtons indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)tagClick
{
    CHGTagViewController *vc = [[CHGTagViewController alloc] init];
    // 隐藏tabbar
//    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
