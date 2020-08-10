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
#import <RACSubject.h>
#import "newsDetailHeaderViewModel.h"
#import "newsDetailFooterView.h"
#import "headLineSearchViewController.h"


@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)WKWebView *newsWebView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)newsDetailHeaderView *headerView;

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)newsDetailHeaderViewModel *headerViewModel;

@property(nonatomic,strong)newsDetailFooterView *footerView;

@property(nonatomic,weak)UIScrollView *containerScrollView;

@property(nonatomic,weak)UIView *contentView;

@end

@implementation NewsDetailViewController

-(newsDetailHeaderViewModel *)headerViewModel{
    if(!_headerViewModel){
        _headerViewModel = [[newsDetailHeaderViewModel alloc]init];
    }
    return _headerViewModel;
}

-(void)setNaviBarItem{
    self.navigationItem.title = @"今日头条";
    
    UIBarButtonItem *moreBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"new_more_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(moreBarHandle:)];
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 2 * hSpace;

    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search_mine_tab"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBarHandle:)];

    self.navigationItem.rightBarButtonItems = @[moreBarBtn,searchBarBtn];
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"lefterbackicon_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBackHandle:)];
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
    [nav stopGestureRecnozier];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviBarItem];
    
    [self setTabBarItem];
//    [self.contentView addSubview:self.headerView];
//    [self.contentView addSubview:self.footerView];
    [self.contentView addSubview:self.newsWebView];
//    [self.contentView addSubview:self.tableView];
//    self.contentView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.containerScrollView];
//    [self.containerScrollView addSubview:self.contentView];
    [self.contentView setFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    [self.view addSubview:self.contentView];

//    self.newsWebView.top = self.headerView.height;
//    self.newsWebView.height = self.view.height;
//    self.tableView.top = self.newsWebView.bottom;
//
    NSURL *url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:8.f];
    [self.newsWebView loadRequest:request];
//
//    self.headerView = [[newsDetailHeaderView alloc]initWithFrame:CGRectMake(0,0, self.view.width, kScreenHeight * 0.2)];
//    [[self.headerViewModel.newsHeaderCommand execute:@13]subscribeNext:^(id  _Nullable x) {
//        NSLog(@"x = %@",x);
//    }];
    
//    _footerView = [[newsDetailFooterView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.6, self.view.width, kScreenHeight * 0.2)];
    // Do any additional setup after loading the view.
}

-(UIScrollView *)containerScrollView{
    if(!_containerScrollView){
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        scrollView.delegate = self;
        scrollView.alwaysBounceVertical = YES;
        _containerScrollView = scrollView;
    }
    return _containerScrollView;
    
}

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView = tableView;
    }
    return _tableView;
}

-(UIView *)contentView{
    if(!_contentView){
        UIView *view = [[UIView alloc]init];
        _contentView = view;
    }
    return _contentView;
}

-(newsDetailHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[newsDetailHeaderView alloc]init];
    }
    return _headerView;
}

-(newsDetailFooterView *)footerView{
    if(!_footerView){
        _footerView = [[newsDetailFooterView alloc]init];
    }
    return _footerView;
}


-(WKWebView *)newsWebView{
    if(!_newsWebView){
        WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        webView.backgroundColor = [UIColor whiteColor];
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
