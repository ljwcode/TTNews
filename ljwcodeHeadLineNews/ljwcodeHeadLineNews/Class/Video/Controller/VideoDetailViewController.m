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
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import "parseVideoRealURLViewModel.h"
#import "TTPlayerView.h"
#import "videoDetailCacheDBViewModel.h"

@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TVVideoPlayerCellDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *detailTableView;

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)videoContentModel *videoPlayModel;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@property(nonatomic,strong)TTPlayerView *playerView;

@property(nonatomic,strong)UITableViewCell *playingCell;

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,strong)videoDetailCacheDBViewModel *videoDBViewModel;

@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.detailTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray addObjectsFromArray:x];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
        }];
        
    }];
    [self.detailTableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
    NSLog(@"number of rows %lu",(unsigned long)self.dataArray.count);
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
    NSLog(@"cell for rows %lu",(unsigned long)self.dataArray.count);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     点击视频播放/跳转播放
     */
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

#pragma mark -- private method

- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    self.videoPlayModel = self.dataArray[indexPath.row];
    [[FBLPromise do:^id _Nullable{
        return [self getVideoURL];
    }]then:^id _Nullable(id  _Nullable value) {
//        return [self playVideo:value];
        return [self playVideoWithURL:value videoIndexPath:indexPath];
    }];
    
}

-(FBLPromise *)getVideoURL{
    return [[[FBLPromise do:^id _Nullable{
        return [[TTNetworkURLManager shareInstance]parseVideoRealURLWithVideo_id:self.videoPlayModel.detailModel.video_detail_info.video_id];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self GetVideoParseData:value];
    }]then:^id _Nullable(id  _Nullable value) {
        self.videoPlayModel = value;
        NSLog(@"video url = %@",self.videoPlayModel.video_list.video_1.main_url);
        return self.videoPlayModel.video_list.video_1.main_url;
    }];
}

/// 播放当前列表第一个视频 同时需要打开下面UIScrollerView的注释
/// @param url 视频的真实URL
-(FBLPromise *)playVideo:(NSString *)url{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        self.videoURL = url;
        [self playVideoInVisiableCells];
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

//进入这个界面就自动播放
-(void)playVideoInVisiableCells{
    TVVideoPlayerViewCell *firstCell = nil;
    NSArray *visiableCells = [self.detailTableView visibleCells];
    
    for (int i = 0; i < visiableCells.count; i++) {
        UITableViewCell *cell = visiableCells[i];
        if ([cell isKindOfClass:[TVVideoPlayerViewCell class]]) {
            firstCell = (TVVideoPlayerViewCell *)cell;
            break;
        }
    }
    //播放第一个视频
    [self initPlayerView:firstCell playClick:firstCell.contentModel];

}


#pragma mark -- TVVideoPlayerCellDelegate


- (void)initPlayerView:(TVVideoPlayerViewCell *)cell playClick:(videoContentModel *)convention{
    self.playingCell = cell;
    [_playerView destroyPlayer];
    _playerView = nil;
    
    TTPlayerView *playerView = [[TTPlayerView alloc] initWithFrame:cell.videoFrame];
    _playerView = playerView;
    
    [cell.contentView addSubview:_playerView];
    
    //视频地址
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_playerView.url = [NSURL URLWithString:self.videoURL];
        //播放
        [self->_playerView playVideo];
        
    });
    
    //返回按钮点击事件回调
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    
    //播放完成回调
    [_playerView endPlay:^{
        [self->_playerView destroyPlayer];
        self->_playerView = nil;
        NSLog(@"播放完成");
    }];
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

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    [self handleScrollPlaying:scrollView];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (!decelerate){
//        [self handleScrollPlaying:scrollView];
//    }
//}
//
//- (void)handleScrollPlaying:(UIScrollView *)scrollView{
//    TVVideoPlayerViewCell *finnalCell = nil;
//    NSArray *visiableCells = [self.detailTableView visibleCells];
//
//    NSMutableArray *tempVideoCells = [NSMutableArray array];
//    for (int i = 0; i < visiableCells.count; i++) {
//        UITableViewCell *cell = visiableCells[i];
//
//        if ([cell isKindOfClass:[TVVideoPlayerViewCell class]]) {
//            [tempVideoCells addObject:cell];
//        }
//    }
//
//    NSMutableArray *indexPaths = [NSMutableArray array];
//    CGFloat gap = MAXFLOAT;
//    for (TVVideoPlayerViewCell *cell in tempVideoCells) {
//
//        [indexPaths addObject:[self.detailTableView indexPathForCell:cell]];
//
//        CGPoint coorCentre = [cell.superview convertPoint:cell.center toView:nil];
//        CGFloat delta = fabs(coorCentre.y-[UIScreen mainScreen].bounds.size.height*0.5);
//        if (delta < gap) {
//            gap = delta;
//            finnalCell = cell;
//        }
//
//    }
//    if (finnalCell != nil && self.playingCell != finnalCell)  {
//        if (_playerView) {
//            [_playerView destroyPlayer];
//            _playerView = nil;
//        }
//
//        [self initPlayerView:finnalCell playClick:finnalCell.contentModel];
//
//        self.playingCell = finnalCell;
//        return;
//    }
//}


#pragma mark ---- lazy load

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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
