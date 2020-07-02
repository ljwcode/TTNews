//
//  homeNewsBrowserViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/2.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsBrowserViewController.h"
#import "ljwcodeHeader.h"
#import <WebKit/WebKit.h>
#import "ljwcodeNavigationController.h"

@interface homeNewsBrowserViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,weak)WKWebView *newsWebView;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation homeNewsBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    // Do any additional setup after loading the view.
}

-(void)configureUI{
    
    [self configureLeftBarButtonItemWithText:@"返回"];
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:8.f];
    [_newsWebView loadRequest:request];
    
}

-(WKWebView *)newsWebView{
    if(!_newsWebView){
        WKWebView *webView = [[WKWebView alloc]init];
        webView.backgroundColor = [UIColor whiteColor];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self.view addSubview:webView];
        
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
            make.top.mas_equalTo(self.view).offset([UIScreen mainScreen].bounds.size.height == 812?88:64);
            make.left.right.mas_equalTo(self.view).offset(0);
        }];
        
        _newsWebView = webView;
    }
    return _newsWebView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ljwcodeNavigationController *nav = (ljwcodeNavigationController *)self.navigationController;
    [nav stopGestureRecnozier];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    ljwcodeNavigationController *nav = (ljwcodeNavigationController *)self.navigationController;
    [nav startGestureRecnozier];
    UIImage *image = [self.navigationController valueForKeyPath:@"defaultImage"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - WKUIDelegate WKNavigationDelegate

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    _hud = [MBProgressHUD showMessag:@"loading..." toView:nil];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [_hud hideAnimated:YES];
}

-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [_hud hideAnimated:YES];
    [MBProgressHUD showMessag:@"loading fail..." toView:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
