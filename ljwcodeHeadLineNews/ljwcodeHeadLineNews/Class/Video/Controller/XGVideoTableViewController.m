//
//  XGVideoTableViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "XGVideoTableViewController.h"
#import "TVVideoPlayerViewCell.h"
#import "videoContentViewModel.h"
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import "parseVideoRealURLViewModel.h"
#import "TTPlayerView.h"
#import "videoDetailCacheDBViewModel.h"
#import "videoDetailViewModel.h"
#import "XGVideoDetailViewController.h"
#import "TTHomeMoreShareVIew.h"

@interface XGVideoTableViewController ()<UITableViewDelegate,UITableViewDataSource,TVVideoPlayerCellDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *detailTableView;

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)videoContentModel *videoContentModel;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@property(nonatomic,strong)TTPlayerView *playerView;

@property(nonatomic,strong)UITableViewCell *playingCell;

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,strong)videoDetailCacheDBViewModel *videoDBViewModel;

@property(nonatomic,strong)videoDetailViewModel *detailViewModel;

@property(nonatomic,strong)XGVideoDetailViewController *detailVC;

@end

@implementation XGVideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    self.detailTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray addObjectsFromArray:x];
            //            NSArray *array = x;
            //            [self.videoDBViewModel TT_saveVideoDataModel:array];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
        }];
    }];
    [self.detailTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    @weakify(self);
    //    self.detailTableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
    //        @strongify(self);
    //        NSArray *array = [self.videoDBViewModel TT_queryVideoDataModel];
    //        [self.dataArray addObjectsFromArray:array];
    //        [self.detailTableView reloadData];
    //        [self.detailTableView.mj_header endRefreshing];
    //    }];
    //    [self.detailTableView.mj_header beginRefreshing];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.playerView destroyPlayer];
    self.playerView = nil;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.detailTableView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationLandscapeRight;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

-(void)needRefreshTableViewData{
    [self.detailTableView setContentOffset:CGPointZero];
    [self.detailTableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDelagate && UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.videoContentModel = self.dataArray[indexPath.row];
    TVVideoPlayerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
    if(!cell){
        cell = [[TVVideoPlayerViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentModel = self.videoContentModel;
    [cell setDelegate:self withIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self playTheVideoAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.dataArray count] - 1) {
        [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0f];
    }
}

-(void)updateData{
    @weakify(self);
    self.detailTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray addObjectsFromArray:x];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_footer endRefreshing];
        }];
    }];
    [self.detailTableView.mj_footer beginRefreshing];
}

- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [[FBLPromise do:^id _Nullable{
        return [self getVideoURLWithIndexPath:indexPath];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self playVideoWithURL:value videoIndexPath:indexPath];
    }];
    
}


-(FBLPromise *)getVideoURLWithIndexPath:(NSIndexPath *)IndexPath{
    return [[[FBLPromise do:^id _Nullable{
        self.videoContentModel = self.dataArray[IndexPath.row];
        NSString *video_id = self.videoContentModel.detailModel.video_detail_info.video_id;
        return [[TTNetworkURLManager shareInstance]parseVideoRealURLWithVideo_id:video_id];
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
        cell = [self.detailTableView cellForRowAtIndexPath:indexPath];
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
    self.playingCell = cell;
    [self.playerView destroyPlayer];
    self.playerView = nil;
    
    TTPlayerView *playerView = [[TTPlayerView alloc]initWithFrame:cell.videoFrame];
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

-(void)TT_commentDetailIndexPath:(NSIndexPath *)indexPath{
    XGVideoDetailViewController *videoDetailVC = [[XGVideoDetailViewController alloc]init];
    self.videoContentModel  = self.dataArray[indexPath.row];
    videoDetailVC.group_id = self.videoContentModel.detailModel.pread_params.group_id;
    videoDetailVC.video_id = self.videoContentModel.detailModel.video_detail_info.video_id;
    [self.navigationController pushViewController:videoDetailVC animated:YES];
}

-(void)TT_TapPushHandleIndexPath:(nonnull NSIndexPath *)indexPath{
    XGVideoDetailViewController *videoDetailVC = [[XGVideoDetailViewController alloc]init];
    self.videoContentModel = self.dataArray[indexPath.row];
    videoDetailVC.group_id = self.videoContentModel.detailModel.pread_params.group_id;
    videoDetailVC.video_id = self.videoContentModel.detailModel.video_detail_info.video_id;
    [self.navigationController pushViewController:videoDetailVC animated:YES];
}

-(void)TT_moreHandle{
    TTHomeMoreShareVIew *moreShareView = [[TTHomeMoreShareVIew alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.5, kScreenWidth, kScreenHeight * 0.5)];
    moreShareView.backgroundColor = [UIColor whiteColor];
    moreShareView.layer.cornerRadius = 8.f;
    moreShareView.layer.masksToBounds = YES;
    [[self.view getCurrentWindow] addSubview:moreShareView];
    
}

#pragma mark ---- UIScrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *cells = [self.detailTableView visibleCells];
    if (![cells containsObject:self.playingCell]) {
        if (_playerView) {
            [_playerView destroyPlayer];
            _playerView = nil;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self handleScrollPlaying:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate){
        [self handleScrollPlaying:scrollView];
    }
}

- (void)handleScrollPlaying:(UIScrollView *)scrollView{
    TVVideoPlayerViewCell *finnalCell = nil;
    NSArray *visiableCells = [self.detailTableView visibleCells];

    NSMutableArray *tempVideoCells = [NSMutableArray array];
    for (int i = 0; i < visiableCells.count; i++) {
        UITableViewCell *cell = visiableCells[i];
        if ([cell isKindOfClass:[TVVideoPlayerViewCell class]]) {
            [tempVideoCells addObject:cell];
        }
    }

    NSMutableArray *indexPaths = [NSMutableArray array];
    CGFloat gap = MAXFLOAT;
    for (TVVideoPlayerViewCell *cell in tempVideoCells) {

        [indexPaths addObject:[self.detailTableView indexPathForCell:cell]];

        CGPoint coorCentre = [cell.superview convertPoint:cell.center toView:nil];
        CGFloat delta = fabs(coorCentre.y-kScreenHeight*0.5);
        if (delta < gap) {
            gap = delta;
            finnalCell = cell;
        }
    }
    if (finnalCell != nil && self.playingCell != finnalCell)  {
        if (_playerView) {
            [_playerView destroyPlayer];
            _playerView = nil;
        }
        return;
    }
}

#pragma mark ---- lazy load

-(XGVideoDetailViewController *)detailVC{
    if(!_detailVC){
        XGVideoDetailViewController *detailVC = [[XGVideoDetailViewController alloc]init];
        _detailVC = detailVC;
    }
    return _detailVC;
}

-(parseVideoRealURLViewModel *)realURLViewModel{
    if(!_realURLViewModel){
        _realURLViewModel = [[parseVideoRealURLViewModel alloc]init];
    }
    return _realURLViewModel;
}

-(videoContentViewModel *)contentViewModel{
    if(!_contentViewModel){
        _contentViewModel = [[videoContentViewModel alloc]init];
    }
    return _contentViewModel;
}

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray  = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(UITableView *)detailTableView{
    if(!_detailTableView){
        _detailTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        [_detailTableView registerClass:[TVVideoPlayerViewCell class] forCellReuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        [self.view addSubview:_detailTableView];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _detailTableView;
}

-(videoDetailCacheDBViewModel *)videoDBViewModel{
    if(!_videoDBViewModel){
        _videoDBViewModel = [[videoDetailCacheDBViewModel alloc]init];
    }
    return _videoDBViewModel;
}

-(videoDetailViewModel *)detailViewModel{
    if(!_detailViewModel){
        _detailViewModel = [[videoDetailViewModel alloc]init];
    }
    return _detailViewModel;
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
