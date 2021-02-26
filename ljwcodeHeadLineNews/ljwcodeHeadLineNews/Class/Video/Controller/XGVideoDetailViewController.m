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

@interface  XGVideoDetailViewController()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,TT_VideoDetailViewDelegate>

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

@end

@implementation XGVideoDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)createUI{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"lefterbackicon_titlebar_dark"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(PopHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_greaterThanOrEqualTo(hSpace);
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

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(FBLPromise *)TT_videoURLBlock{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        self.VideoDetailBlock = ^(NSString * _Nonnull videoURL) {
            fulfill(videoURL);
        };
    }];
}

-(void)TT_getVideoURLToPlay{
    [[FBLPromise do:^id _Nullable{
        return [self TT_videoURLBlock];
    }]then:^id _Nullable(id  _Nullable value) {
        [self TT_PlayVideo:value];
        return self.videoURL = value;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TT_getVideoURLToPlay];
    [self.TTVVideoDetailContainerScrollView addSubview:self.commentScrollView];
    
    [[self.commentViewModel.ComRacCommand execute:self.group_id]subscribeNext:^(id  _Nullable x) {
        NSLog(@"x = %@",x);
        [self.UserCommentDataArray addObjectsFromArray:x];
        self.commentScrollView.commentBlock(self.UserCommentDataArray);
    }];
    
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

-(void)TT_PlayVideo:(NSString *)URL{
    [self.view addSubview:self.playerView];
    
    [self.view addSubview:self.TTVVideoDetailContainerScrollView];
    [self.TTVVideoDetailContainerScrollView addSubview:self.TTThemedTableView];
    [self.TTVVideoDetailContainerScrollView addSubview:self.detailView];
    self.TTThemedTableView.tableHeaderView = self.detailView;
    [self.TTVVideoDetailContainerScrollView addSubview:self.authorHeaderView];
    
    [self createUI];
    
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

#pragma mark ----- lazy load

-(TTPlayerView *)playerView{
    if(!_playerView){
        _playerView = [[TTPlayerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.3)];
    }
    return _playerView;
}

-(XGVideoCommentViewModel *)commentViewModel{
    if(!_commentViewModel){
        _commentViewModel = [[XGVideoCommentViewModel alloc]init];
    }
    return _commentViewModel;
}

-(TT_UserCommnetScrollView *)commentScrollView{
    if(!_commentScrollView){
        _commentScrollView = [[TT_UserCommnetScrollView alloc]initWithFrame:self.TTVVideoDetailContainerScrollView.bounds];
        _commentScrollView.backgroundColor = [UIColor whiteColor];
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
        _authorHeaderView = [[TTVideoDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.1)];
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
        _TTVVideoDetailContainerScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - CGRectGetHeight(self.playerView.frame));
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
        _TTThemedTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.authorHeaderView.frame), kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _TTThemedTableView.separatorColor = [UIColor clearColor];
        _TTThemedTableView.delegate = self;
        _TTThemedTableView.dataSource = self;
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
    if(self.playerView){
        [self.playerView pausePlay];
        self.playerView = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------- TT_VideoDetailViewDelegate

-(void)TT_VideoDetailCommentView{
    [self.TTVVideoDetailContainerScrollView addSubview:self.commentScrollView];
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
