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

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation VideoDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:YES animated:animated];

}

-(void)createUI{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"lefterbackicon_titlebar_dark"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(PopHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(hSpace);
        make.width.height.mas_equalTo(20);
    }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    [self createUI];
    [self.view addSubview:self.TTVVideoDetailContainerScrollView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_playerView.url = [NSURL URLWithString:self.videoURL];
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
    // Do any additional setup after loading the view.
}

#pragma mark ----- UITableViewDelegate && UITableViewDataSource



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


#pragma mark ------- 响应事件
-(void)PopHandle:(UIButton *)sender{
    
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
