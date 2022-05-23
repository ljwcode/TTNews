//
//  homeTableViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTableViewController.h"
#import "homeNewsTableViewCell.h"
#import "homeNewsMiddleVideoViewCell.h"
#import "homeNewsImgListTableViewCell.h"
#import "homeNewsModel.h"
#import "homeNewsCellViewModel.h"
#import "homeNewsMiddleCoverViewModel.h"
#import "NewsDetailViewController.h"
#import "TVVideoPlayerViewCell.h"
#import "videoContentModel.h"
#import "UIScrollView+EmptyDataSet.h"
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import "parseVideoRealURLViewModel.h"
#import "TTPlayerView.h"
#import "homeNewsDetailDBViewModel.h"
#import "homeMicroVideoRequestViewModel.h"

@interface homeTableViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UIGestureRecognizerDelegate,TTHomeNewsTableViewDelegate>

@property(nonatomic,weak)UITableView *detailTableView;

@property(nonatomic,strong)homeNewsCellViewModel *newsCellViewModel;

@property(nonatomic,strong)NSMutableArray *datasArray;

@property(nonatomic,strong)homeNewsSummaryModel *model;

@property(nonatomic,strong)microVideoDetailModel *microModel;

@property(nonatomic,strong)videoContentModel *videoPlayModel;

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@property(nonatomic,strong)UITableViewCell *playingCell;

@property(nonatomic,strong)TTPlayerView *playerView;

@property(nonatomic,strong)homeMicroVideoRequestViewModel *microVideoViewModel;

@end

@implementation homeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"isNotInternet"]){
        [self TT_loadCacheData];
    }else {
        [self TT_onLineRefreshData];
    }
}

-(void)TT_loadCacheData{
    homeNewsDetailDBViewModel *dbViewModel = [[homeNewsDetailDBViewModel alloc]init];
    __block NSArray *dataArray = [NSArray array];
    dataArray = [dbViewModel TT_quertNewsDetailData:self.titleModel.category];
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
        homeNewsMicroVideoModel *newsModel = (homeNewsMicroVideoModel *)model;
        return newsModel.data;
    }
}

#pragma mark ----- lazy load

-(homeMicroVideoRequestViewModel *)microVideoViewModel{
    if(!_microVideoViewModel){
        _microVideoViewModel = [[homeMicroVideoRequestViewModel alloc]init];
    }
    return  _microVideoViewModel;
}

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
        tableView.estimatedRowHeight = 80;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        //设置UITableViewCell
        
        [tableView registerClass:[homeNewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
        
        [tableView registerClass:[homeNewsMiddleVideoViewCell class] forCellReuseIdentifier:NSStringFromClass([homeNewsMiddleVideoViewCell class])];
        
        [tableView registerClass:[homeNewsImgListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([homeNewsImgListTableViewCell class])];
        
        [tableView registerClass:[TVVideoPlayerViewCell class] forCellReuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        
        [tableView registerClass:[TT_horizontalCardCell class] forCellReuseIdentifier:NSStringFromClass([TT_horizontalCardCell class])];
        
        [tableView registerClass:[TTRecTopNewsTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TTRecTopNewsTableViewCell class])];
        
        [tableView registerClass:[TTHomeMicroToutiaoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TTHomeMicroToutiaoTableViewCell class])];
        
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
    [self TT_onLineRefreshData];
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
        if(!cell){
            cell = [[TVVideoPlayerViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        }
        videoContentModel *model = self.datasArray[indexPath.row];
        cell.contentModel = model;
        resultCell = cell;
        
    }else{
        self.model = self.datasArray[indexPath.row];
        if([self.model.infoModel.cell_flag isEqualToString:@"285474827"]){
            if(self.model.infoModel.image_list){
                homeNewsImgListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeNewsImgListTableViewCell class])];
                if(!cell){
                    cell = [[homeNewsImgListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([homeNewsImgListTableViewCell class])];
                }
                cell.newsSummaryModel = self.model;
                cell.delegate = self;
                resultCell = cell;
            }else {
                TTHomeNewsRightVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTHomeNewsRightVideoTableViewCell class])];
                if(!cell){
                    cell = [[TTHomeNewsRightVideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTHomeNewsRightVideoTableViewCell class])];
                }
                cell.newsVideoModel = self.model;
                resultCell = cell;
            }
            
        }else if([self.model.infoModel.cell_flag isEqualToString:@"285474825"]){
            homeNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
            if(!cell){
                cell = [[homeNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([homeNewsTableViewCell class])];
            }
            cell.summaryModel = self.model;
            resultCell = cell;
        }else if([self.model.infoModel.cell_flag isEqualToString:@"285474891"]){
            homeNewsMiddleVideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([homeNewsMiddleVideoViewCell class])];
            if(!cell){
                cell = [[homeNewsMiddleVideoViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([homeNewsMiddleVideoViewCell class])];
            }
            cell.summaryModel = self.model;
            resultCell = cell;
        }else if([self.model.infoModel.cell_flag isEqualToString:@"274071561"]){
            TTHomeMicroToutiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTHomeMicroToutiaoTableViewCell class])];
            if(!cell){
                cell = [[TTHomeMicroToutiaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTHomeMicroToutiaoTableViewCell class])];
            }
            cell.summaryModel = self.model;
            cell.delegate = self;
            resultCell = cell;
        }else{
            /*
             else if([self.model.infoModel.cell_flag isEqualToString:@"352583689"])
             */
            TTRecTopNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTRecTopNewsTableViewCell class])];
            if(!cell){
                cell = [[TTRecTopNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TTRecTopNewsTableViewCell class])];
            }
            cell.summaryModel = self.model;
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
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return  YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self TTDeleteNewsCellHandle];
        [self.datasArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row > 5){
        return YES;
    }
    return NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *str = [self.datasArray objectAtIndex:sourceIndexPath.row];
    [self.datasArray removeObjectAtIndex:sourceIndexPath.row];
    [self.datasArray insertObject:str atIndex:destinationIndexPath.row];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.detailTableView setEditing:editing animated:animated];
}

#pragma mark ---- 上拉刷新更新数据

-(void)updateData{
    @weakify(self);
    self.detailTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [[self.newsCellViewModel.newsCellViewCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            NSArray *datasArray = [self modelArrayWithCategory:self.titleModel.category fromModel:x];
            [self.datasArray addObjectsFromArray:datasArray];

            [self.detailTableView reloadData];
            [self.detailTableView.mj_footer endRefreshing];
        }];
        
    }];
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
    float height = scrollView.contentSize.height > _detailTableView.frame.size.height ? _detailTableView.frame.size.height : scrollView.contentSize.height;
    if((height - scrollView.contentSize.height + scrollView.contentOffset.y) / height > 0.2){
        [self updateData];
    }
    NSArray *cells = [self.detailTableView visibleCells];
    if (![cells containsObject:self.playingCell]) {
        
        if (_playerView) {
            [_playerView destroyPlayer];
            _playerView = nil;
        }
    }
}

#pragma mark ------- TTHomeNewsTableViewDelegate

- (void)TTDeleteNewsCellHandle {
    NSLog(@"删除cell");
}

-(void)TTMicroToutiaoLikeHandle {
    NSLog(@"like");
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
