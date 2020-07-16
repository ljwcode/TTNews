//
//  VideoViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "VideoViewController.h"
#import "ljwcodeHeader.h"
#import "videoTitleViewModel.h"
#import "VideoDetailViewController.h"
#import "videoTitleModel.h"

@interface VideoViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong)videoTitleViewModel *titleViewModle;

@property(nonatomic,strong)NSMutableArray *titleArray;


@end

@implementation VideoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    ljwcodeNavigationBar *navBar = [self showNaviBar];
    
    [navBar.navigationBarActionSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self configureUI];
    
    @weakify(self)
    [[self.titleViewModle.videoCommand execute:@18] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.titleArray = x;
        [self reloadData];
        [self setPageMenuView];
    }];
    
    //channel title 从网络中获取得到
    [navBar setLjwcodeActionCallBack:^(ljwcodeNavigationBarAction action) {
        //        @strongify(self);
        if(action != ljwcodeNavigationBarActionSend){
            
        }else{
            NSLog(@"send");
        }
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)configureUI{
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
}

-(void)setPageMenuView{

    @weakify(self)
    [RACObserve(self.scrollView, contentOffset) subscribeNext:^(id x) {
        @strongify(self);
        CGPoint offset = [x CGPointValue];
        if (offset.x > [UIScreen mainScreen].bounds.size.width * (self.titleArray.count - 1)) {
            self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (self.titleArray.count - 1), 0);
        }
    }];
    
}

#pragma mark - WMPageController delelgate && datasource
-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    if(self.titleArray.count == 0||!_titleArray){
        return 0;
    }
    return self.titleArray.count+1;
}
//设置每一个分页栏展示的控制器及内容
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    if (index > self.titleArray.count - 1) {
        return  [[VideoDetailViewController alloc]init];
    }
    videoTitleModel *model = self.titleArray[index];
    VideoDetailViewController *detail = [[VideoDetailViewController alloc]init];
    detail.titleModel = model;
    return detail;

}
//设置每一个channel的title
-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    if (index > self.titleArray.count - 1) {
        return @"       ";
    }else {
        videoTitleModel *model = self.titleArray[index];
        return model.name;
    }
}

#pragma mark - MenuViewDelegate

-(void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    if(index == -1){
        [self needRefreshTableViewData];
    }else{
        [super menuView:menu didSelesctedIndex:index currentIndex:currentIndex];
    }
    
}

-(videoTitleViewModel *)titleViewModle{
    if(!_titleViewModle){
        _titleViewModle = [[videoTitleViewModel alloc]init];
    }
    return _titleViewModle;
}

-(void)needRefreshTableViewData{
    VideoDetailViewController *videoDetailVC = (VideoDetailViewController *)self.currentViewController;
    [videoDetailVC needRefreshTableViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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