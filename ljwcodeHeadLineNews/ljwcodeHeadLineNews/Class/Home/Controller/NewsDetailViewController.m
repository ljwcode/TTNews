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
#import "TTHomeMoreShareVIew.h"
#import <Masonry/Masonry.h>
#import "homeNewsDetailRecSearchViewModel.h"
#import "homeArticleContentViewModel.h"
#import "TT_UserCommentTableViewCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "homeNewsDetailCommentViewModel.h"
#import "TT_UserCommentModel.h"
#import <MJRefresh/MJRefresh.h>

@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)newsDetailFooterView *footerView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic, strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)NSMutableArray *userCommentArray;

@property(nonatomic,strong)homeNewsDetailRecSearchViewModel *newsRecViewModel;

@property(nonatomic,strong)homeArticleContentViewModel *ArticleContentViewModel;

@property(nonatomic,strong)homeNewsDetailCommentViewModel *CommentViewModel;

@end

@implementation NewsDetailViewController

-(void)TT_NaviBarItem{

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
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.headerView];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.webView;
    [self.webView addSubview:self.footerView];

    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(TT_isIphoneX ? 34 : 0);;
        make.height.mas_equalTo(TT_TabBarHeight);
    }];
    [self TT_NaviBarItem];
    
    [[self.newsRecViewModel.recSearchCommand execute:self.group_id]subscribeNext:^(id  _Nullable x)  {

    }];

    [[self.ArticleContentViewModel.ArticleContentCommand execute:self.group_id]subscribeNext:^(id  _Nullable x) {
        
    } completed:^{
        NSURL *baseUrl = [NSURL URLWithString:@"file:///assets/"];
        [self.webView loadHTMLString:[self.ArticleContentViewModel TT_getHTMLString] baseURL:baseUrl];
    }];
    [self TT_CommentFeedBack];
}

-(void)TT_CommentFeedBack{
    self.tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [[self.CommentViewModel.newsDetailCommend execute:self.group_id]subscribeNext:^(id  _Nullable x) {
            [self.userCommentArray addObjectsFromArray:x];
            [self.tableView reloadData];
            NSLog(@"commentArray = %@",self.userCommentArray);
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark ---- UITableViewDelegate && UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"commentArray = %lu",(unsigned long)self.userCommentArray.count);
    return self.userCommentArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TT_UserCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TT_UserCommentTableViewCell class])];
    if(!cell){
        cell = [[TT_UserCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TT_UserCommentTableViewCell class])];
    }
    TT_UserCommentModel *model = self.userCommentArray[indexPath.row];
    cell.commentModel = model;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *HeaderView = [[UIView alloc]init];
        HeaderView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(hSpace, 0, 60, 20)];
        titleLabel.text = @"评论";
        titleLabel.font = [UIFont systemFontOfSize:16.f weight:6.f];
        titleLabel.textColor = [UIColor blackColor];
        [HeaderView addSubview:titleLabel];
        return HeaderView;
    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return self.userCommentArray.count > 0 ? 40 : CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 49;
}

#pragma mark ------- UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([scrollView isEqual:self.tableView]){
        CGFloat OffSetY = scrollView.contentOffset.y;
        if(OffSetY <= 0){
            self.webView.scrollView.scrollEnabled = YES;
            self.tableView.bounces = NO;
        }else{
            self.webView.scrollView.scrollEnabled = NO;
            self.tableView.bounces = YES;
        }
    }
}

#pragma mark - WKUIDelegate WKNavigationDelegate

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    // 适当增大字体大小
    NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%%'"];
    [webView evaluateJavaScript:js completionHandler:nil];
    webView.allowsBackForwardNavigationGestures = YES;
}


#pragma mark ------ kvo

// 计算wkWebView高度，
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]){
        self.webView.height = self.webView.scrollView.contentSize.height;
        self.tableView.tableHeaderView = self.webView;
    }
}
#pragma mark ---- lazy load


-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, kScreenHeight - TT_TabBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11, *)) {
           _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UINib *TT_userCommentNib = [UINib nibWithNibName:NSStringFromClass([TT_UserCommentTableViewCell class]) bundle:nil];
        [_tableView registerNib:TT_userCommentNib forCellReuseIdentifier:NSStringFromClass([TT_UserCommentTableViewCell class])];
    }
    return _tableView;
}


-(homeArticleContentViewModel *)ArticleContentViewModel{
    if(!_ArticleContentViewModel){
        _ArticleContentViewModel = [[homeArticleContentViewModel alloc]init];
    }
    return _ArticleContentViewModel;
}

-(homeNewsDetailRecSearchViewModel *)newsRecViewModel{
    if(!_newsRecViewModel){
        _newsRecViewModel = [[homeNewsDetailRecSearchViewModel alloc]init];
    }
    return _newsRecViewModel;
}

-(UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, TT_statuBarHeight, kScreenWidth, TT_statuBarHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

-(WKWebView *)webView{
    if(!_webView){
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        _webView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1) configuration:configuration];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        if(@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}

-(newsDetailFooterView *)footerView{
    if(!_footerView){
        _footerView = [[newsDetailFooterView alloc]init];
        _footerView.layer.borderColor = [UIColor grayColor].CGColor;
        _footerView.layer.borderWidth = 0.5f;
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

-(homeNewsDetailCommentViewModel *)CommentViewModel{
    if(!_CommentViewModel){
        _CommentViewModel = [[homeNewsDetailCommentViewModel alloc]init];
    }
    return _CommentViewModel;
}

-(NSMutableArray *)userCommentArray{
    if(!_userCommentArray){
        _userCommentArray = [[NSMutableArray alloc]init];
    }
    return _userCommentArray;
}

#pragma mark - 点击事件响应

-(void)moreBarHandle:(id)sender{
    TTHomeMoreShareVIew *moreShareView = [[TTHomeMoreShareVIew alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.5, kScreenWidth, CGRectGetHeight(self.view.frame) * 0.5)];
    moreShareView.backgroundColor = [UIColor whiteColor];
    moreShareView.layer.cornerRadius = 8.f;
    moreShareView.layer.masksToBounds = YES;
    [self.view addSubview:moreShareView];
}

-(void)searchBarHandle:(id)sender{
    TTSearchViewController *searchVC = [[TTSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)leftBackHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"newsDealloc");
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
