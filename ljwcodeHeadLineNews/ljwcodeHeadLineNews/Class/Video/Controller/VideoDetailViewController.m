//
//  VideoDetailViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "VideoDetailViewController.h"
#import <Masonry/Masonry.h>
#import "TTPlayerView.h"

@interface  VideoDetailViewController()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)TTPlayerView *playerView;

@property(nonatomic,strong)UIView *authorHeaderView;

@property(nonatomic,strong)UITableView *TTThemedTableView;

@property(nonatomic,strong)UIScrollView *TTVVideoDetailContainerScrollView;

@end

@implementation VideoDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    [self.view addSubview:self.TTVVideoDetailContainerScrollView];
    
    // Do any additional setup after loading the view.
}

#pragma mark ----- lazy load

-(TTPlayerView *)playerView{
    if(!_playerView){
        _playerView = [[TTPlayerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.3)];
        _playerView.url = [NSURL URLWithString:self.videoURL];
    }
    return _playerView;
}

-(UIView *)authorHeaderView{
    if(!_authorHeaderView){
        _authorHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playerView.frame), kScreenWidth, kScreenHeight * 0.1)];
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

#pragma mark ----- createUI

-(void)createAuthorView{
    [self.TTVVideoDetailContainerScrollView addSubview:self.authorHeaderView];
    [self.authorHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreenHeight * 0.1);
    }];
    
    
}

#pragma mark ----- UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
       CGFloat playerViewH = self.playerView.frame.size.height;
       //scrollView的滚动的Y值
       CGFloat offsetY = scrollView.contentOffset.y;
       if (offsetY >= playerViewH) {
           //当向上滑动到状态栏边缘的时候，将红色控件添加到控制器View中
           CGRect redFrame = self.authorHeaderView.frame;
           redFrame.origin.y = 0;
           self.authorHeaderView.frame = redFrame;
           [self.view addSubview:self.authorHeaderView];
       }else {
           //下拉到scrollView顶部时候，将红色控件添加到控制器scrollView中
           CGRect redFrame = self.authorHeaderView.frame;
           redFrame.origin.y = playerViewH;
           self.authorHeaderView.frame = redFrame;
           [self.TTVVideoDetailContainerScrollView addSubview:self.authorHeaderView];
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
