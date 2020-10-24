//
//  VideoDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "TVVideoPlayerViewCell.h"
#import "videoContentViewModel.h"
#import "TTHeader.h"

#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>

#import "parseVideoRealURLViewModel.h"

@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TVVideoPlayerCellDelegate>

@property(nonatomic,strong)UITableView *detailTableView;

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)videoContentModel *videoPlayModel;

@property(nonatomic,strong)ZFPlayerController *player;

@property(nonatomic,strong)ZFPlayerControlView *playerControlView;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@end

@implementation VideoDetailViewController

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
        if (@available(iOS 11.0, *)) {
            _detailTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _detailTableView.estimatedRowHeight = 0;
        _detailTableView.estimatedSectionFooterHeight = 0;
        _detailTableView.estimatedSectionHeaderHeight = 0;
        
    }
    return _detailTableView;
}

- (ZFPlayerControlView *)playerControlView {
    if (!_playerControlView) {
        _playerControlView = [[ZFPlayerControlView alloc]init];
        _playerControlView.prepareShowLoading = YES;
        _playerControlView.prepareShowControlView = YES;
    }
    return _playerControlView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.detailTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray addObjectsFromArray:x];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
            [self.detailTableView.mj_footer endRefreshing];
        }];
    }];
    self.detailTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray addObjectsFromArray:x];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
            [self.detailTableView.mj_footer endRefreshing];
        }];
        
    }];
    [self.detailTableView.mj_header beginRefreshing];
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.detailTableView playerManager:playerManager containerViewTag:kPlayerViewTag];
    self.player.controlView = self.playerControlView;
    self.player.shouldAutoPlay = NO;
    /// 1.0是完全消失的时候
    self.player.playerDisapperaPercent = 1.0;
    
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        kAppDelegate.allowOrentitaionRotation  = isFullScreen;
    };
    
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self);
        [self.player stopCurrentPlayingCell];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.detailTableView.frame = self.view.bounds;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
    self.videoPlayModel = self.dataArray[indexPath.row];
    TVVideoPlayerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
    if(!cell){
        cell = [[TVVideoPlayerViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentModel = self.videoPlayModel;
    [cell setDelegate:self withIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     点击视频播放/跳转播放
     */
    if (self.player.playingIndexPath != indexPath) {
        [self.player stopCurrentPlayingCell];
    }
    /// 如果没有播放，则点击进详情页会自动播放
    if (!self.player.currentPlayerManager.isPlaying) {
        [self playTheVideoAtIndexPath:indexPath];
    }
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark -- private method

- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
//    //video_id 拼接url
    self.videoPlayModel = self.dataArray[indexPath.row];
    NSString *urlString = [[networkURLManager shareInstance]parseVideoRealURLWithVideo_id:self.videoPlayModel.detailModel.video_detail_info.video_id];
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    [[self.realURLViewModel.VideoRealURLCommand execute:@13]subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        self.videoPlayModel = x;
        dispatch_semaphore_signal(sem);
    }];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    NSString *videoURL = self.videoPlayModel.video_list.video_1.main_url;
    [self.player playTheIndexPath:indexPath assetURL:[NSURL URLWithString:videoURL]];
        [self.playerControlView showTitle:_videoPlayModel.detailModel.title coverURLString:[_videoPlayModel.detailModel.video_detail_info.detail_video_large_image objectForKey:@"url"]  fullScreenMode:_videoPlayModel.isVerticalVideo ? ZFFullScreenModePortrait : ZFFullScreenModeLandscape];
}

#pragma mark -- TVVideoPlayerCellDelegate

-(void)VideoPlayerAtIndexPath:(NSIndexPath *)indexPath{
    [self playTheVideoAtIndexPath:indexPath];
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
