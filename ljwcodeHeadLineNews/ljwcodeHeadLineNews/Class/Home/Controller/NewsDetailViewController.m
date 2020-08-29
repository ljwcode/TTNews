//
//  NewsDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/2.
//  Copyright © 2020 ljwcode. All rights reserved.
//
#import "NewsDetailViewController.h"
#import "TTHeader.h"
#import <WebKit/WebKit.h>
#import "TTNavigationController.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>
#import <RACSubject.h>
#import "newsDetailFooterView.h"
#import "headLineSearchViewController.h"


@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)WKWebView *newsWebView;

@property(nonatomic,strong)MBProgressHUD *hud;

//@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)newsDetailFooterView *footerView;

//@property(nonatomic,weak)UIScrollView *containerScrollView;

@property(nonatomic,assign)CGFloat webViewHeight;

@end

@implementation NewsDetailViewController

-(void)setNaviBarItem{
    self.navigationItem.title = @"今日头条";
    
    UIImage *moreImg = [[UIImage imageNamed:@"new_more_titlebar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *moreBarBtn = [[UIBarButtonItem alloc]initWithImage:moreImg style:UIBarButtonItemStylePlain target:self action:@selector(moreBarHandle:)];
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 2 * hSpace;
    
    UIImage *searchImg = [[UIImage imageNamed:@"search_mine_tab"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc]initWithImage:searchImg style:UIBarButtonItemStylePlain target:self action:@selector(searchBarHandle:)];

    self.navigationItem.rightBarButtonItems = @[moreBarBtn,searchBarBtn];
    
    UIImage *leftImg = [[UIImage imageNamed:@"lefterbackicon_titlebar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:leftImg style:UIBarButtonItemStylePlain target:self action:@selector(leftBackHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

-(void)setTabBarItem{
    UITabBar *tabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, self.view.height * 0.8, self.view.width, self.view.height * 0.2)];
    [self.view addSubview:tabBar];
    tabBar.barTintColor = [UIColor clearColor];
    [self.footerView setFrame:tabBar.bounds];
    [tabBar addSubview:self.footerView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    TTNavigationController *nav = (TTNavigationController *)self.navigationController;
    [nav startGestureRecnozier];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webViewHeight = 0.0;
    
    [self setNaviBarItem];
    
    [self setTabBarItem];
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:8.f];
    [self.newsWebView loadRequest:request];

}

//#pragma mark -- lazy load
//-(UIScrollView *)containerScrollView{
//    if(!_containerScrollView){
//        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight * 2)];
//        scrollView.delegate = self;
//        scrollView.alwaysBounceVertical = YES;
//        [self.view addSubview:scrollView];
//        scrollView.maximumZoomScale = 1;
//        scrollView.minimumZoomScale = 1;
//        [scrollView setBouncesZoom:NO];
//        _containerScrollView = scrollView;
//    }
//    return _containerScrollView;
//
//}

//-(UITableView *)tableView{
//    if(!_tableView){
//        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.8) style:UITableViewStylePlain];
//        tableView.delegate = self;
//        tableView.dataSource = self;
//        tableView.contentInset = UIEdgeInsetsZero;
//        tableView.showsVerticalScrollIndicator = NO;
//        tableView.showsHorizontalScrollIndicator = NO;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NewsContent"];
//        [self.view addSubview:tableView];
//        _tableView = tableView;
//    }
//    return _tableView;
//}

-(newsDetailFooterView *)footerView{
    if(!_footerView){
        _footerView = [[newsDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * 0.2)];
    }
    return _footerView;
}


-(WKWebView *)newsWebView{
    if(!_newsWebView){
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        wkWebConfig.userContentController = wkUController;

        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

        [wkUController addUserScript:wkUserScript];
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight * 2) configuration:wkWebConfig];
        webView.backgroundColor = [UIColor clearColor];
        webView.opaque = NO;
        webView.userInteractionEnabled = NO;
        webView.scrollView.bounces = NO;
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [webView sizeToFit];
//        [webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [webView loadRequest:urlRequest];
        [self.view addSubview:webView];
        _newsWebView = webView;
    }
    return _newsWebView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    TTNavigationController *nav = (TTNavigationController *)self.navigationController;
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

#pragma mark - UITableViewDelegate && UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultCell = nil;
    switch(indexPath.row){
        case 0:
        {
            static NSString *cellID = @"NewsContent";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cellID){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            [cell.contentView addSubview:self.newsWebView];
            resultCell = cell;
            
        }
            break;
    }
    return resultCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.webViewHeight;
}

#pragma mark - 点击事件响应

-(void)moreBarHandle:(UIBarButtonItem *)sender{
    
}

-(void)searchBarHandle:(UIBarButtonItem *)sender{
    headLineSearchViewController *searchVC = [[headLineSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)leftBackHandle:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - kvo

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if([keyPath isEqualToString:@"contentSize"]){
//        UIScrollView *scrollView = (UIScrollView *)object;
//        CGFloat height = scrollView.contentSize.height;
//        self.webViewHeight = height;
//        self.newsWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
//        self.containerScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
//        self.containerScrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
//    }
//}

-(void)dealloc{
    [self.newsWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
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
