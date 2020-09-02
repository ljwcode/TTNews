//
//  ScreenHallVideoDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ScreenHallVideoDetailViewController.h"
#import "TTHeader.h"
#import "VideoCoverCollectionViewCell.h"
#import "TTVideoPlayer.h"
#import "TTVideoToolBar.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "videoContentViewModel.h"

@interface ScreenHallVideoDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)videoContentViewModel *contentViewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ScreenHallVideoDetailViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    @weakify(self);
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [[self.contentViewModel.videoContentCommand execute:self.titleModel.category]subscribeNext:^(id  _Nullable x) {
            [self.dataArray removeAllObjects];
            [self->_dataArray addObjectsFromArray:x];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
        }];
        
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

#pragma mark -- lazy load

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / 16 * 9 + TTToolBarHeight);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[VideoCoverCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([VideoCoverCollectionViewCell class])];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(videoContentViewModel *)contentViewModel{
    if(!_contentViewModel){
        _contentViewModel = [[videoContentViewModel alloc]init];
    }
    return _contentViewModel;
}

#pragma mark -- UICollectionDelegate && UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //需要返回数据个数
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([VideoCoverCollectionViewCell class]) forIndexPath:indexPath];
    videoContentModel *model = self.dataArray[indexPath.row];
    NSString *videoID = model.detailModel.video_detail_info.video_id;
    NSString *url = [[networkURLManager shareInstance]parseVideoRealURLWithVideo_id:videoID];
    if ([cell isKindOfClass:[VideoCoverCollectionViewCell class]]) {
        [(VideoCoverCollectionViewCell *)cell layoutWithVideoCoverUrl:[model.detailModel.video_detail_info.detail_video_large_image objectForKey:@"url"] videoUrl:url];
    }
    return cell;
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
