//
//  homeTableViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTableViewController.h"
#import "homeNewsTableViewCell.h"
#import "homejokeTableViewCell.h"
#import "homeContentNewsTableViewCell.h"
#import "homeNewsModel.h"
#import "homeNewsCellViewModel.h"
#import "homeJokeModel.h"
#import "NewsDetailViewController.h"
#import "TVVideoPlayerViewCell.h"
#import "videoContentModel.h"
#import "UIScrollView+EmptyDataSet.h"
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import "parseVideoRealURLViewModel.h"
#import "TTPlayerView.h"
#import "homeNewsDetailDBViewModel.h"
#import <AFNetworkReachabilityManager.h>

@interface homeTableViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UIGestureRecognizerDelegate>

@property(nonatomic,weak)UITableView *detailTableView;

@property(nonatomic,strong)homeNewsCellViewModel *newsCellViewModel;

@property(nonatomic,strong)NSMutableArray *datasArray;

@property(nonatomic,strong)homeNewsSummaryModel *model;

@property(nonatomic,strong)videoContentModel *videoPlayModel;

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@property(nonatomic,strong)UITableViewCell *playingCell;

@property(nonatomic,strong)TTPlayerView *playerView;

@end

@implementation homeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [self TT_loadCacheData];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self TT_onLineRefreshData];
            default:
                break;
        }
    }];
    [manager startMonitoring];
    // Do any additional setup after loading the view.
}

-(void)TT_loadCacheData{
    homeNewsDetailDBViewModel *dbViewModel = [[homeNewsDetailDBViewModel alloc]init];
    __block NSArray *dataArray = [NSArray array];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dataArray = [dbViewModel TT_quertNewsDetailData:self.titleModel.category];
    });
    [self.datasArray addObjectsFromArray:dataArray];
    [self.detailTableView reloadData];
}



-(void)TT_onLineRefreshData{
    self.detailTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[self.newsCellViewModel.newsCellViewCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            homeNewsDetailDBViewModel *dbViewModel = [[homeNewsDetailDBViewModel alloc]init];
            __block NSArray *array = [NSArray array];
            array = [self modelArrayWithCategory:self.titleModel.category fromModel:x];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [dbViewModel TT_saveHomeNewsDetailModel:array TT_DetailCategory:self.titleModel.category];
            });
            NSRange range = NSMakeRange(0, [array count]);
            [self.datasArray insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
        }];
    }];
    [self.detailTableView.mj_header beginRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.playerView destroyPlayer];
    self.playerView = nil;
}

-(NSArray *)modelArrayWithCategory:(NSString *)category fromModel:(id)model{
    if([category isEqualToString:@"video"]){
        return model;
    }else{
        homeNewsModel *newsModel = (homeNewsModel *)model;
        return newsModel.data;
    }
}

#pragma mark ----- lazy load

-(parseVideoRealURLViewModel *)realURLViewModel{
    if(!_realURLViewModel){
        _realURLViewModel = [[parseVideoRealURLViewModel alloc]init];
    }
    return _realURLViewModel;
}

-(NSMutableArray *)datasArray{
    if(!_datasArray){
        _datasArray = [[NSMutableArray alloc]init];
    }
    return _datasArray;
}

-(homeNewsCellViewModel *)newsCellViewModel{
    if(!_newsCellViewModel){
        _newsCellViewModel = [[homeNewsCellViewModel alloc]init];
    }
    return _newsCellViewModel;
}

-(UITableView *)detailTableView{
    if(!_detailTableView){
        UITableView *tableView = [[UITableView alloc]init];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        //设置UITableViewCell
        
        UINib *newsTableViewCell = [UINib nibWithNibName:NSStringFromClass([homeNewsTableViewCell class]) bundle:nil];
        [tableView registerNib:newsTableViewCell forCellReuseIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
        
        UINib *jokeTableViewCell = [UINib nibWithNibName:NSStringFromClass([homejokeTableViewCell class]) bundle:nil];
        [tableView registerNib:jokeTableViewCell forCellReuseIdentifier:NSStringFromClass([homejokeTableViewCell class])];
        
        UINib *contentNewsCell = [UINib nibWithNibName:NSStringFromClass([homeContentNewsTableViewCell class]) bundle:nil];
        [tableView registerNib:contentNewsCell forCellReuseIdentifier:NSStringFromClass([homeContentNewsTableViewCell class])];
        
        [tableView registerClass:[TVVideoPlayerViewCell class] forCellReuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        
        _detailTableView = tableView;
    }
    return _detailTableView;
}

-(videoContentModel *)videoPlayModel{
    if(!_videoPlayModel){
        _videoPlayModel = [[videoContentModel alloc]init];
    }
    return _videoPlayModel;
}

-(void)needRefreshTableViewData{
    if([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        return;
    }
    [self.detailTableView setContentOffset:CGPointZero];
//    [self.detailTableView.mj_header beginRefreshing];
}

#pragma mark - DZNEmptyDataSetDelegate && DZNEmptyDataSetSource

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"not_network_loading"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSString *text = @"当前网络不可用，点击重试";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:15.0]
                   range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor lightGrayColor]
                   range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:[UIColor blueColor]
                   range:NSMakeRange(8, 4)];
    return attStr;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -70.0f;
}

/*
 点击重试 重新执行刷新请求
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self needRefreshTableViewData];

}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.detailTableView.contentOffset = CGPointZero;
}

#pragma mark - UITableViewDelegate && UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *resultCell = nil;
    if([self.titleModel.category isEqualToString:@"video"]){
        TVVideoPlayerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        videoContentModel *model = self.datasArray[indexPath.row];
        cell.contentModel = model;
        resultCell = cell;
        
    }else{
        _model = self.datasArray[indexPath.row];
        if(_model.infoModel.image_list){
            homeNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
            if(!cell){
                cell = [[homeNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
            }
            cell.summaryModel = _model;
            resultCell = cell;
        }else{
            homeContentNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeContentNewsTableViewCell class])];
            if(!cell){
                cell = [[homeContentNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([homeContentNewsTableViewCell class])];
            }
            cell.newsSummaryModel = _model;
            resultCell = cell;
        }
    }
    return resultCell;
}

//点击news cell跳转到新闻显示界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailViewController *webVC = [[NewsDetailViewController alloc]init];
    self.model  = self.datasArray[indexPath.row];
    if([self.titleModel.category isEqualToString:@"video"]){
        NSLog(@"播放视频");
        [self playTheVideoAtIndexPath:indexPath];
    }else{
        webVC.group_id = _model.infoModel.group_id;
        NSLog(@"articleURL = %@",_model.infoModel.article_url);
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == [self.datasArray count] - 1) {
//        [self performSelector:@selector(updateData) withObject:nil afterDelay:1.0f];
//    }
}

-(void)updateData{
    @weakify(self);
    self.detailTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [[self.newsCellViewModel.newsCellViewCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            NSArray *datasArray = [self modelArrayWithCategory:self.titleModel.category fromModel:x];
            [self.datasArray addObjectsFromArray:datasArray];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
        }];
    }];
    [self.detailTableView.mj_header beginRefreshing];
}

#pragma mark ----- UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark -- private method

- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    self.videoPlayModel = self.datasArray[indexPath.row];
    [[FBLPromise do:^id _Nullable{
        return [self getVideoURLWithIndexPath:indexPath];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self playVideoWithURL:value videoIndexPath:indexPath];
    }];
}

-(FBLPromise *)getVideoURLWithIndexPath:(NSIndexPath *)IndexPath{
    return [[[FBLPromise do:^id _Nullable{
        self.videoPlayModel = self.datasArray[IndexPath.row];
        return [[TTNetworkURLManager shareInstance]parseVideoRealURLWithVideo_id:self.videoPlayModel.detailModel.video_detail_info.video_id];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self GetVideoParseData:value];
    }]then:^id _Nullable(id  _Nullable value) {
        self.videoPlayModel = value;
        return value;
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.playerView.url = [NSURL URLWithString:self.videoURL];
        [self.playerView playVideo];
        
    });
    
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
