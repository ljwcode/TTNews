//
//  NewsDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/2.
//  Copyright © 2020 ljwcode. All rights reserved.
//
#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "TTNavigationController.h"
#import <RACSubject.h>
#import "newsDetailFooterView.h"
#import "TTSearchViewController.h"
#import "TTWebView.h"
#import "TTHomeMoreShareVIew.h"
#import <Masonry/Masonry.h>


@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,TTWebViewDelegate>

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)newsDetailFooterView *footerView;

@property(nonatomic,assign)CGFloat webViewHeight;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)TTWebView *webView;

@property(nonatomic, strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UIView *headerView;

@end

@implementation NewsDetailViewController

-(void)setNaviBarItem{

    UIButton *BackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [BackBtn setImage:[UIImage imageNamed:@"lefterbackicon_titlebar"] forState:UIControlStateNormal];
    [BackBtn addTarget:self action:@selector(leftBackHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:BackBtn];
    [BackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(2 * hSpace);
        make.centerY.mas_equalTo(self.headerView);
        make.width.height.mas_equalTo(20);
    }];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:[UIImage imageNamed:@"new_more_titlebar"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBarHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-2 * hSpace);
        make.centerY.mas_equalTo(self.headerView);
        make.width.height.mas_equalTo(20);
    }];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"search_mine_tab"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBarHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(moreBtn.mas_left).offset(-2 * hSpace);
        make.centerY.mas_equalTo(self.headerView);
        make.height.width.mas_equalTo(20);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];

    [self setNaviBarItem];

    NSURL *URL = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

#pragma mark ---- UITableViewDelegate && UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return self.webView;
    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark ---- TTWebViewDelegate

-(void)webViewDidFinishLoad:(TTWebView *)webView{
    self.webView.height = self.webView.scrollView.contentSize.height;
    [self.tableView reloadData];
}

#pragma mark ---- lazy load

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, TT_statuBarHeight, kScreenWidth, TT_statuBarHeight)];
    }
    return _headerView;
}

-(TTWebView *)webView{
    if(!_webView){
        _webView = [[TTWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,300)];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.opaque = NO;
    }
    return _webView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, kScreenHeight - CGRectGetHeight(self.headerView.frame)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.borderColor = [UIColor redColor].CGColor;
        _tableView.layer.borderWidth = 1.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentSize = CGSizeMake(kScreenWidth, CGFLOAT_MAX);
    }
    return _tableView;
}

-(newsDetailFooterView *)footerView{
    if(!_footerView){
        _footerView = [[newsDetailFooterView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.9, kScreenWidth, kScreenHeight * 0.1)];
        _footerView.layer.borderColor = [UIColor blueColor].CGColor;
        _footerView.layer.borderWidth = 2.f;
    }
    return _footerView;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImage *image = [self.navigationController valueForKeyPath:@"defaultImage"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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

#pragma mark - 点击事件响应

-(void)moreBarHandle:(UIBarButtonItem *)sender{
    TTHomeMoreShareVIew *moreShareView = [[TTHomeMoreShareVIew alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.5, kScreenWidth, CGRectGetHeight(self.view.frame) * 0.5)];
    moreShareView.backgroundColor = [UIColor whiteColor];
    moreShareView.layer.cornerRadius = 8.f;
    moreShareView.layer.masksToBounds = YES;
    [self.view addSubview:moreShareView];
}

-(void)searchBarHandle:(UIBarButtonItem *)sender{
    TTSearchViewController *searchVC = [[TTSearchViewController alloc]init];
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
