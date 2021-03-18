//
//  XGVideoDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "XGVideoDetailViewController.h"
#import <Masonry/Masonry.h>
#import "TTPlayerView.h"
#import "TTVideoDetailHeaderView.h"
#import "videoDetailViewModel.h"
#import "TT_VideoDetailModel.h"
#import "TTVideoDetailView.h"
#import "TTRecommandVideoTableViewCell.h"
#import "XGVideoDetailRecommendViewModel.h"
#import "TT_UserCommnetScrollView.h"
#import "XGVideoCommentViewModel.h"
#import "TTHomeMoreShareVIew.h"
#import "TTSearchViewController.h"
#import <FBLPromises/FBLPromises.h>
#import "TVVideoPlayerViewCell.h"
#import "parseVideoRealURLViewModel.h"
#import "videoContentModel.h"
#import "XGVideoTableViewController.h"
#import <TTNews-Swift.h>

@interface  XGVideoDetailViewController()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TT_VideoDetailViewDelegate,UIGestureRecognizerDelegate,TT_UserCommentDelegate,TTPlayerEndMaskDelegate>

@property(nonatomic,strong)TTPlayerView *playerView;

@property(nonatomic,strong)TTVideoDetailHeaderView *authorHeaderView;

@property(nonatomic,strong)UITableView *TTThemedTableView;

@property(nonatomic,strong)UIScrollView *TTVVideoDetailContainerScrollView;

@property(nonatomic,strong)NSMutableArray *RecommendVideoDataArray;

@property(nonatomic,strong)NSMutableArray *UserCommentDataArray;

@property(nonatomic,assign)CGFloat minY;

@property(nonatomic,strong)videoDetailViewModel *viewModel;

@property(nonatomic,strong)TT_VideoDetailModel *videoDetailModel;

@property(nonatomic,strong)TTVideoDetailView *detailView;

@property(nonatomic,strong)XGVideoDetailRecommendViewModel *VideoRecommendViewModel;

@property(nonatomic,strong)TT_UserCommnetScrollView *commentScrollView;

@property(nonatomic,strong)XGVideoCommentViewModel *commentViewModel;

@property(nonatomic,strong)UIView *TT_commentSuperView;

@property(nonatomic,strong)UIView *customerStatusBar;

@property(nonatomic,strong)TVVideoPlayerViewCell *playerCell;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@property(nonatomic,strong)videoContentModel *contentModel;

@property(nonatomic,strong)TTPlayerEndMaskView *endMaskView;


@end

@implementation XGVideoDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupStatusBarColor:[UIColor blackColor]];
    });
    
    if (@available(ios 13.0, *)) {
        if (self.customerStatusBar) {
            self.customerStatusBar.hidden = NO;
        }
    }
}

//设置状态栏颜色
- (void)setupStatusBarColor:(UIColor *)color{
    if (@available(iOS 13.0, *)) {
        // iOS 13 不能直接获取到statusbar 手动添加个view到window上当做statusbar背景
        if (!self.customerStatusBar) {
            UIWindow *keyWindow = [self.view getCurrentWindow];
            self.customerStatusBar = [[UIView alloc] initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
            [keyWindow addSubview:self.customerStatusBar];
        }
    } else {
        self.customerStatusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    if ([self.customerStatusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        [self.customerStatusBar setBackgroundColor:color];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self setupStatusBarColor:[UIColor clearColor]];
    [self.playerView destroyPlayer];
    self.playerView = nil;
}

-(void)TT_createNaviBar{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"lefterbackicon_titlebar_dark"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(PopHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hSpace);
        make.top.mas_equalTo(TT_statuBarHeight);
        make.width.height.mas_equalTo(20);
    }];
    
    UIButton *MoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [MoreBtn setImage:[UIImage imageNamed:@"new_morewhite_titlebar"] forState:UIControlStateNormal];
    [MoreBtn addTarget:self action:@selector(MoreHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:MoreBtn];
    [MoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backBtn);
        make.right.mas_equalTo(-hSpace);
        make.width.height.mas_equalTo(20);
    }];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"tsv_overlaytop_search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MoreBtn);
        make.right.mas_equalTo(MoreBtn.mas_left).offset(-hSpace * 2);
        make.width.height.mas_equalTo(20);
    }];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.TTVVideoDetailContainerScrollView];
    [self.TTVVideoDetailContainerScrollView addSubview:self.TTThemedTableView];
    [self.TTVVideoDetailContainerScrollView addSubview:self.detailView];
    self.TTThemedTableView.tableHeaderView = self.detailView;
    [self.TTVVideoDetailContainerScrollView addSubview:self.authorHeaderView];
    
    [self TT_createNaviBar];
    
    [self TT_Player];
    
    self.TTThemedTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [[self.viewModel.videoDetailCommand execute:self.group_id]subscribeNext:^(id  _Nullable x) {
            self.videoDetailModel = x;
            self.authorHeaderView.detailModel = self.videoDetailModel;
            self.detailView.detailModel = self.videoDetailModel;
        }];
        
        [[self.VideoRecommendViewModel.videoRecCommand execute:@"video"]subscribeNext:^(id  _Nullable x) {
            NSLog(@"x = %@",x);
            [self.RecommendVideoDataArray addObjectsFromArray:x];
            [self.TTThemedTableView reloadData];
            [self.TTThemedTableView.mj_header endRefreshing];
        }];
    }];
    [self.TTThemedTableView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

-(void)TT_PlayVideoWithURL:(NSString *)URL{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.playerView.url = [NSURL URLWithString:URL];
        [self.playerView playVideo];
    });
    //返回按钮点击事件回调
    [self.playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [self.playerView endPlay:^{
        [self.playerView destroyPlayer];
        self.playerView = nil;
        NSLog(@"播放完成");
        [self.view addSubview:self.endMaskView];
    }];
}

-(void)TT_Player{
    [[FBLPromise do:^id _Nullable{
        return [self getVideoURL];
    }]then:^id _Nullable(id  _Nullable value) {
        [self TT_PlayVideoWithURL:value];
        return value;
    }];
}

#pragma mark ----- UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.RecommendVideoDataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = NSStringFromClass([TTRecommandVideoTableViewCell class]);
    TTRecommandVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[TTRecommandVideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    videoContentModel *model = self.RecommendVideoDataArray[indexPath.row];
    cell.contentModel = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [self playTheVideoAtIndexPath:indexPath];
}

- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [[FBLPromise do:^id _Nullable{
        return [self getVideoURL];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self playVideoWithURL:value videoIndexPath:indexPath];
    }];
    
}


-(FBLPromise *)getVideoURL{
    return [[[FBLPromise do:^id _Nullable{
        return [[TTNetworkURLManager shareInstance]parseVideoRealURLWithVideo_id:self.video_id];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self GetVideoParseData:value];
    }]then:^id _Nullable(id  _Nullable value) {
        self.videoURL = value;
        return value;
    }];
}

-(FBLPromise *)playVideoWithURL:(NSString *)url videoIndexPath:(NSIndexPath*)indexPath{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        self.videoURL = url;
        
        TVVideoPlayerViewCell *cell = nil;
        cell = [self.TTThemedTableView cellForRowAtIndexPath:indexPath];
        [self initPlayerView:cell playClick:cell.contentModel];
    }];
}

-(FBLPromise *)GetVideoParseData:(id)input{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        [[self.realURLViewModel.VideoRealURLCommand execute:input]subscribeNext:^(id  _Nullable x) {
            fulfill(x);
        }];
    }];
}

#pragma mark -- TVVideoPlayerCellDelegate

- (void)initPlayerView:(TVVideoPlayerViewCell *)cell playClick:(videoContentModel *)convention{
    self.playerCell = cell;
    [self.playerView destroyPlayer];
    self.playerView = nil;
    
    TTPlayerView *playerView = [[TTPlayerView alloc]initWithFrame:self.playerView.bounds];
    self.playerView = playerView;
    [cell.contentView addSubview:self.playerView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.playerView.url = [NSURL URLWithString:self.videoURL];
        [self.playerView playVideo];
    });
    
    [self.playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    
    [self.playerView endPlay:^{
        [self.playerView destroyPlayer];
        self.playerView = nil;
        NSLog(@"播放完成");
    }];
}

#pragma mark ----- lazy load

-(parseVideoRealURLViewModel *)realURLViewModel{
    if(!_realURLViewModel){
        _realURLViewModel = [[parseVideoRealURLViewModel alloc]init];
    }
    return _realURLViewModel;
}

-(UIView *)TT_commentSuperView{
    if(!_TT_commentSuperView){
        _TT_commentSuperView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playerView.frame), kScreenWidth, CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.playerView.frame))];
        _TT_commentSuperView.backgroundColor = [UIColor whiteColor];
    }
    return _TT_commentSuperView;
}

-(TTPlayerView *)playerView{
    if(!_playerView){
        _playerView = [[TTPlayerView alloc]initWithFrame:CGRectMake(0, TT_statuBarHeight, kScreenWidth, kScreenHeight * 0.3)];
    }
    return _playerView;
}

-(TTPlayerEndMaskView *)endMaskView{
    if(!_endMaskView){
        _endMaskView = [[TTPlayerEndMaskView alloc]initWithFrame:CGRectMake(0, TT_statuBarHeight, kScreenWidth, kScreenHeight * 0.3)];
        _endMaskView.delegate = self;
    }
    return _endMaskView;
}

-(XGVideoCommentViewModel *)commentViewModel{
    if(!_commentViewModel){
        _commentViewModel = [[XGVideoCommentViewModel alloc]init];
    }
    return _commentViewModel;
}

-(TT_UserCommnetScrollView *)commentScrollView{
    if(!_commentScrollView){
        _commentScrollView = [[TT_UserCommnetScrollView alloc]initWithFrame:self.TT_commentSuperView.bounds];
        _commentScrollView.backgroundColor = [UIColor whiteColor];
        _commentScrollView.delegate = self;
    }
    return _commentScrollView;
}

-(NSMutableArray *)RecommendVideoDataArray{
    if(!_RecommendVideoDataArray){
        _RecommendVideoDataArray = [[NSMutableArray alloc]init];
    }
    return _RecommendVideoDataArray;
}

-(NSMutableArray *)UserCommentDataArray{
    if(!_UserCommentDataArray){
        _UserCommentDataArray = [[NSMutableArray alloc]init];
    }
    return _UserCommentDataArray;
}

-(TTVideoDetailView *)detailView{
    if(!_detailView){
        _detailView = [[TTVideoDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.2)];
        _detailView.delegate = self;
    }
    return _detailView;
}

-(TTVideoDetailHeaderView *)authorHeaderView{
    if(!_authorHeaderView){
        _authorHeaderView = [[TTVideoDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _authorHeaderView.backgroundColor = [UIColor whiteColor];
        _authorHeaderView.layer.borderColor = [UIColor grayColor].CGColor;
        _authorHeaderView.layer.borderWidth = 0.5f;
        _minY = 0;
    }
    return _authorHeaderView;
}

-(UIScrollView *)TTVVideoDetailContainerScrollView{
    if(!_TTVVideoDetailContainerScrollView){
        _TTVVideoDetailContainerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playerView.frame), kScreenWidth, kScreenHeight - CGRectGetHeight(self.playerView.frame))];
        _TTVVideoDetailContainerScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
        _TTVVideoDetailContainerScrollView.delegate = self;
    }
    return _TTVVideoDetailContainerScrollView;
}

-(videoDetailViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[videoDetailViewModel alloc]init];
    }
    return _viewModel;
}

-(XGVideoDetailRecommendViewModel *)VideoRecommendViewModel{
    if(!_VideoRecommendViewModel){
        _VideoRecommendViewModel = [[XGVideoDetailRecommendViewModel alloc]init];
    }
    return _VideoRecommendViewModel;
}

-(UITableView *)TTThemedTableView{
    if(!_TTThemedTableView){
        _TTThemedTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.authorHeaderView.frame), kScreenWidth, CGRectGetHeight(self.view.frame) - TT_TabBarHeight) style:UITableViewStylePlain];
        _TTThemedTableView.separatorColor = [UIColor clearColor];
        _TTThemedTableView.delegate = self;
        _TTThemedTableView.dataSource = self;
        _TTThemedTableView.bounces = NO;
        _TTThemedTableView.bouncesZoom = NO;
        UINib *VideoRecNib = [UINib nibWithNibName:NSStringFromClass([TTRecommandVideoTableViewCell class]) bundle:nil];
        [_TTThemedTableView registerNib:VideoRecNib forCellReuseIdentifier:NSStringFromClass([TTRecommandVideoTableViewCell class])];
    }
    return _TTThemedTableView;
}

#pragma mark ----- UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGRect frame = self.authorHeaderView.frame;
    if (offsetY >= _minY) {
        frame.origin.y = 0;
    }else{
        frame.origin.y = _minY;
    }
    self.authorHeaderView.frame = frame;
}


#pragma mark ------- 响应事件

-(void)MoreHandle:(UIButton *)sender{
    TTHomeMoreShareVIew *moreShareView = [[TTHomeMoreShareVIew alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.5, kScreenWidth, CGRectGetHeight(self.view.frame) * 0.5)];
    moreShareView.backgroundColor = [UIColor whiteColor];
    moreShareView.layer.cornerRadius = 8.f;
    moreShareView.layer.masksToBounds = YES;
    [self.view addSubview:moreShareView];
}

-(void)searchHandle:(UIButton *)sender{
    TTSearchViewController *searchVC = [[TTSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)PopHandle:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------- TT_VideoDetailViewDelegate

-(void)TT_VideoDetailCommentView{
    [self.view addSubview:self.TT_commentSuperView];
    [self.TT_commentSuperView addSubview:self.commentScrollView];
    [[self.commentViewModel.ComRacCommand execute:self.group_id]subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
        [self.UserCommentDataArray addObjectsFromArray:x];
        self.commentScrollView.commentBlock(self.UserCommentDataArray);
    }];
}

#pragma mark ------- TT_UserCommentDelegate
-(void)TT_RemoveCommentView{
    [self.TT_commentSuperView removeFromSuperview];
    [self.commentScrollView removeFromSuperview];
}

#pragma mark ----- NSNotification observer

-(void)TT_NotifiDestroyPlayer:(NSNotification *)notification{
    [self.playerView destroyPlayer];
    self.playerView = nil;
}

#pragma mark ---- TTPlayerEndMaskDelegate

-(void)TT_MoreHandle{
    TTHomeMoreShareVIew *moreShareView = [[TTHomeMoreShareVIew alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.5, kScreenWidth, CGRectGetHeight(self.view.frame) * 0.5)];
    moreShareView.backgroundColor = [UIColor whiteColor];
    moreShareView.layer.cornerRadius = 8.f;
    moreShareView.layer.masksToBounds = YES;
    [self.view addSubview:moreShareView];
}

-(void)TT_SearchHandle{
    TTSearchViewController *searchVC = [[TTSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)TT_BackPopHandle{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)TT_ReplayerVideoHandle{
    
}

-(void)dealloc{
    NSLog(@"videoDetailVC dealloc");
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
