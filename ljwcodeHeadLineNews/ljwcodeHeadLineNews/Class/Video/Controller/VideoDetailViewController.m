//
//  VideoDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "TVVideoPlayerViewCell.h"
#import "shortVideoPlayerViewCell.h"
#import "videoContentViewModel.h"
#import "ljwcodeHeader.h"

@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *detailTableView;

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)videoContentModel *videoPlayModel;

@end

@implementation VideoDetailViewController

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
        _detailTableView = [[UITableView alloc]init];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        [self.view addSubview:_detailTableView];
        
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.estimatedRowHeight = 0;
        [_detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UINib *TVNib = [UINib nibWithNibName:NSStringFromClass([TVVideoPlayerViewCell class]) bundle:nil];
        [_detailTableView registerNib:TVNib forCellReuseIdentifier:NSStringFromClass([TVVideoPlayerViewCell class])];
        
        UINib *shortVideoNib = [UINib nibWithNibName:NSStringFromClass([shortVideoPlayerViewCell class]) bundle:nil];
        [_detailTableView registerNib:shortVideoNib forCellReuseIdentifier:NSStringFromClass([shortVideoPlayerViewCell class])];
        
    }
    return _detailTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.detailTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray removeAllObjects];
            [self->_dataArray addObjectsFromArray:x];
            [self.detailTableView reloadData];
            [self.detailTableView.mj_header endRefreshing];
            [self.detailTableView.mj_footer endRefreshing];
        }];
        
    }];
    [self.detailTableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
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
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    videoContentModel *model = self.dataArray[indexPath.row];
    shortVideoPlayerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([shortVideoPlayerViewCell class])];
    cell.contentModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     点击视频播放/跳转播放
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 225;
}

-(void)setVideoPlayModel:(videoContentModel *)videoPlayModel{
    if (_videoPlayModel.playing) {
        _videoPlayModel.playing = NO;
        NSInteger index = [self.dataArray indexOfObject:_videoPlayModel];
        shortVideoPlayerViewCell *cell = [self.detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        [cell refreshCellStatus];
    }
    _videoPlayModel = videoPlayModel;
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
