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
#import "newsDetailHeaderView.h"

@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)WKWebView *newsWebView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)newsDetailHeaderView *headerView;

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,weak)UIScrollView *scrollView;

@end

static CGFloat VSpace = 10;
@implementation NewsDetailViewController

-(void)viewDidLayoutSubviews{
    self.navigationController.title = @"今日头条";
    [[UINavigationBar appearance]setTranslucent:NO];
    [[UINavigationBar appearance]setBackgroundColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setHidden:YES];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"lefterbackicon_titlebar"] forState:UIControlStateNormal];
    self.navigationController.navigationItem.backBarButtonItem.customView = backBtn;
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn addTarget:self action:@selector(moreBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setImage:[UIImage imageNamed:@"new_more_titlebar"] forState:UIControlStateNormal];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"search_mine_tab"] forState:UIControlStateNormal];

    self.navigationController.navigationItem.rightBarButtonItems = @[moreBtn,searchBtn];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureWebUI];
    
    _headerView = [[newsDetailHeaderView alloc]initWithFrame:CGRectMake(0,VSpace, self.view.width, kScreenHeight * 0.2)];
    self.tableView.tableHeaderView = _headerView;
    // Do any additional setup after loading the view.
}

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.scrollView.frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.scrollView addSubview:tableView];
    }
    return _tableView;
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        scrollView.delegate = self;
        scrollView.bounces = NO;
        scrollView.contentOffset = CGPointMake(0, self.tableView.height);
        scrollView.contentSize = CGSizeMake(self.view.width, self.tableView.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = YES;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(void)configureWebUI{
    
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:8.f];
    [self.newsWebView loadRequest:request];
    
}

-(WKWebView *)newsWebView{
    if(!_newsWebView){
        WKWebView *webView = [[WKWebView alloc]init];
        webView.backgroundColor = [UIColor whiteColor];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        [self.tableView addSubview:webView];
        
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
    TTNavigationController *nav = (TTNavigationController *)self.navigationController;
    [nav stopGestureRecnozier];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
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
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cellID){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

#pragma mark - 点击事件响应

-(void)moreBtnHandle:(UIButton *)sender{
    
}

-(void)searchBtnHandle:(UIButton *)sender{
    
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
