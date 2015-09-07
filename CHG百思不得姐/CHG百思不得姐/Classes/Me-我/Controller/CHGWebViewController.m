//
//  CHGWebViewController.m
//  CHG百思不得姐
//
//  Created by chenhongen on 15/9/7.
//  Copyright (c) 2015年 陈弘根. All rights reserved.
//

#import "CHGWebViewController.h"
#import "CHGSquare.h"

@interface CHGWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CHGWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.title = self.square.name;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
    self.webView.backgroundColor = CHGGlobalBg;
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (IBAction)back{
    [self.webView goBack];
}

- (IBAction)forward{
    [self.webView goForward];
}

- (IBAction)refresh{
    [self.webView reload];
}

#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}


@end
