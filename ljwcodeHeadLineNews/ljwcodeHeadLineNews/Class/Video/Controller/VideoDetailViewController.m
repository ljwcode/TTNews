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
#import "VideoPlayerContainerView.h"

@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,TVVideoPlayerCellDelegate>

@property(nonatomic,strong)UITableView *detailTableView;

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)videoContentModel *videoPlayModel;

@property(nonatomic,strong)parseVideoRealURLViewModel *realURLViewModel;

@property(nonatomic,strong)VideoPlayerContainerView *player;

@end

@implementation VideoDetailViewController

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
        if (@available(iOS 11.0, *)) {
            _detailTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _detailTableView;
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
    self.player = [[VideoPlayerContainerView alloc]initWithFrame:cell.bounds];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self playTheVideoAtIndexPath:indexPath];
}

#pragma mark -- private method

- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    self.videoPlayModel = self.dataArray[indexPath.row];
    [[FBLPromise do:^id _Nullable{
        return [self getVideoURL];
    }]then:^id _Nullable(id  _Nullable value) {
        return [self playVideo:value];
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

-(FBLPromise *)playVideo:(NSString *)url{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        self.player.urlVideo = url;
        [self.view addSubview:self.player];
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
