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


@interface NewsDetailViewController ()<WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,TTWebViewDelegate>

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)newsDetailFooterView *footerView;

@property(nonatomic,assign)CGFloat webViewHeight;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)TTWebView *webView;

@property(nonatomic, strong)NSMutableArray *imageArray;

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webViewHeight = 0.0;
    [self setNaviBarItem];
    [self.view addSubview:self.tableView];
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
        [cell.contentView addSubview:self.webView];
        NSURL *URL = [NSURL URLWithString:_urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:request];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _webViewHeight;
}

#pragma mark ---- TTWebViewDelegate

-(void)webViewDidFinishLoad:(TTWebView *)webView{
    [self.webView evaluateJavaScript:@"document.documentElement.scrollHeight" completionHandler:^(id object, NSError *error) {
        CGFloat height = [object integerValue];
        if (error != nil) {
        }else{
            self->_webViewHeight = height;
            [self->_tableView beginUpdates];
            self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, self->_tableView.frame.size.width, self->_webViewHeight );
        }
        [self->_tableView endUpdates];
    }];
    
//    插入js代码，对图片进行点击操作
    [webView evaluateJavaScript:@"function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0; i < length;i++){img=imgs[i];if(\"ad\" ==img.getAttribute(\"flag\")){var parent = this.parentNode;if(parent.nodeName.toLowerCase() != \"a\")return;}img.onclick=function(){window.location.href='image-preview:'+this.src}}}" completionHandler:^(id object, NSError *error) {
    }];
    [webView evaluateJavaScript:@"assignImageClickAction();" completionHandler:^(id object, NSError *error) {
        
    }];
    [self getImgs];
}

-(BOOL)webView:(TTWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([request.URL isEqual:@"about:blank"]){
        return true;
    }
    if ([request.URL.scheme isEqualToString: @"image-preview"]){
        return NO;
    }
    //    用户点击文章详情中的链接
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        return NO;
    }
        return YES;
}

#pragma mark -- 获取文章中的图片个数

- (NSArray *)getImgs{
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self nodeCountOfTag:@"img"]; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        [self.webView evaluateJavaScript:jsString completionHandler:^(NSString *str, NSError *error) {
            if (error ==nil) {
                [arrImgURL addObject:str];
            }
        }];
    }
    _imageArray = [NSMutableArray arrayWithArray:arrImgURL];
    
    
    return arrImgURL;
}

// 获取某个标签的结点个数
- (NSInteger)nodeCountOfTag:(NSString *)tag{
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
 
    __block int count;
    [self.webView evaluateJavaScript:jsString completionHandler:^(id result, NSError *error) {
        count = (int)result;
    }];
    return count;
}

#pragma mark ---- lazy load

-(TTWebView *)webView{
    if(!_webView){
        _webView = [[TTWebView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.bounces = NO;
        _webView.opaque = NO;
    }
    return _webView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
