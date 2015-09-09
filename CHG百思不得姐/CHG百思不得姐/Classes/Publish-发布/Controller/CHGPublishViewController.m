//
//  CHGPublishViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/9.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGPublishViewController.h"
#import "CHGPublishButton.h"
#import <POP.h>

@interface CHGPublishViewController ()
@property (nonatomic, weak) UIImageView *sloganView;
/** 动画时间 */
@property (nonatomic, strong) NSArray *times;

@end

@implementation CHGPublishViewController

- (NSArray *)times
{
    if (!_times) {
        CGFloat interval = 0.1; // 时间间隔
        _times = @[@(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(0 * interval),
                   @(1 * interval),
                   @(6 * interval)]; // 标语的动画时间
    }
    return _times;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标语
    [self setupSlogan];
    
    // 按钮数据
    [self setupButton];
}

- (void)setupSlogan
{
    CGFloat sloganY = CHGScreenH * 0.2;
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = sloganY - CHGScreenH;
    sloganView.centerX = CHGScreenW * 0.5;
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    POPSpringAnimation *anm = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anm.toValue = @(sloganY);
    anm.springBounciness = 10;
    anm.springSpeed = 10;
    // CACurrentMediaTime()获得的是当前时间
    anm.beginTime = CACurrentMediaTime() + [self.times.lastObject doubleValue];
    [sloganView.layer pop_addAnimation:anm forKey:nil];
}

- (void)setupButton
{
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    NSUInteger count = images.count;
    int maxColsCount = 3; // 一行的列数
    NSUInteger rowsCount = (count + maxColsCount - 1) / maxColsCount;
    
    CGFloat buttonW = CHGScreenW / maxColsCount;
    CGFloat buttonH = buttonW * 0.85;
    CGFloat buttonStartY = ( CHGScreenH - buttonH * rowsCount ) / 2 ;
    for (int i = 0; i < count; ++i) {
        
        CHGPublishButton *button = [CHGPublishButton buttonWithType:UIButtonTypeCustom];
        button.width = -1; // 按钮的尺寸为0，还是能看见文字缩成一个点，设置按钮的尺寸为负数，那么就看不见文字了
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat buttonX = (i % maxColsCount) * buttonW;
        CGFloat buttonY = buttonStartY + (i / maxColsCount ) * buttonH;
        
        // 设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        
        POPSpringAnimation *anm = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anm.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - CHGScreenH, buttonW, buttonH)];
        anm.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anm.springSpeed = 10;
        anm.springBounciness = 10;
        // CACurrentMediaTime()获得的是当前时间
        anm.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button pop_addAnimation:anm forKey:nil];
        
    }
}

- (void)buttonClick:(CHGPublishButton *)button
{
    
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)backbtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
