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

@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)newsDetailFooterView *footerView;

@property(nonatomic,assign)CGFloat webViewHeight;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WKWebView *webView;

@property(nonatomic, strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)NSArray *userCommentArray;

@property(nonatomic,strong)UIView *TT_CommentFooterView;

@property(nonatomic,strong)homeNewsDetailRecSearchViewModel *newsRecViewModel;

@property(nonatomic,strong)homeArticleContentViewModel *ArticleContentViewModel;

@property(nonatomic,strong)homeNewsDetailCommentViewModel *CommentViewModel;

@end

@implementation NewsDetailViewController

#pragma mark -------- get USER Comment Data


-(void)createFooterView{
    
    [self.view addSubview:self.TT_CommentFooterView];
    
    UITextField *CommentTextField = [[UITextField alloc]init];
    CommentTextField.layer.borderColor = [UIColor grayColor].CGColor;
    CommentTextField.layer.borderWidth = 1.f;
    CommentTextField.layer.cornerRadius = 10.f;
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:@"写评论..." attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11.f],NSForegroundColorAttributeName : [UIColor blackColor]}];
    CommentTextField.attributedText = attrString;
    CommentTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftImgView.image = [UIImage imageNamed:@"hts_vp_write_new"];
    CommentTextField.leftViewMode = UITextFieldViewModeAlways;
    [CommentTextField.leftView addSubview:leftImgView];
    
    CommentTextField.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CommentTextField.rightView.bounds];
    rightImgView.image = [UIImage imageNamed:@"tsv_comment_footer_emoji"];
    [CommentTextField.rightView addSubview:rightImgView];
    CommentTextField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.TT_CommentFooterView addSubview:CommentTextField];
    [CommentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hSpace * 2);
        make.right.mas_equalTo(-hSpace * 2);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}

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
    [self.view addSubview:self.headerView];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-34);
    }];
    self.tableView.tableHeaderView = self.webView;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-34);
    }];
    [self TT_NaviBarItem];
    [[self.newsRecViewModel.recSearchCommand execute:self.group_id]subscribeNext:^(id  _Nullable x)  {

    }];

    [[self.ArticleContentViewModel.ArticleContentCommand execute:self.group_id]subscribeNext:^(id  _Nullable x) {
        
    } completed:^{
        NSURL *baseUrl = [NSURL URLWithString:@"file:///assets/"];
        [self.webView loadHTMLString:[self.ArticleContentViewModel TT_getHTMLString] baseURL:baseUrl];
    }];
    
    [[self.CommentViewModel.newsDetailCommend execute:self.group_id]subscribeNext:^(id  _Nullable x) {
        self.userCommentArray = x;
    }];
}

#pragma mark ---- UITableViewDelegate && UITableViewDatasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        titleLabel.text = @"评论";
        titleLabel.font = [UIFont systemFontOfSize:13.f weight:6.f];
        titleLabel.textColor = [UIColor blackColor];
        return titleLabel;
    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return 60;
        }else{
            return 81;
        }
    }
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return self.userCommentArray.count > 0 ? 40 : CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
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
    
    self.webView.height = self.webView.scrollView.contentSize.height;
    [self.tableView reloadData];
}

#pragma mark ---- lazy load

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
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
    }
    return _headerView;
}

-(WKWebView *)webView{
    if(!_webView){
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

-(newsDetailFooterView *)footerView{
    if(!_footerView){
        _footerView = [[newsDetailFooterView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.9, kScreenWidth, kScreenHeight * 0.1)];
        _footerView.layer.borderColor = [UIColor blueColor].CGColor;
        _footerView.layer.borderWidth = 2.f;
    }
    return _footerView;
}

-(UIView *)TT_CommentFooterView{
    if(!_TT_CommentFooterView){
        _TT_CommentFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.9, kScreenWidth, CGRectGetHeight(self.view.frame) * 0.1)];
        _TT_CommentFooterView.layer.borderColor = [UIColor grayColor].CGColor;
        _TT_CommentFooterView.layer.borderWidth = 1.f;
    }
    return _TT_CommentFooterView;
}

-(homeNewsDetailCommentViewModel *)CommentViewModel{
    if(!_CommentViewModel){
        _CommentViewModel = [[homeNewsDetailCommentViewModel alloc]init];
    }
    return _CommentViewModel;
}

-(NSArray *)userCommentArray{
    if(!_userCommentArray){
        _userCommentArray = [[NSArray alloc]init];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
