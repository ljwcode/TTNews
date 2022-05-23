//
//  ScreeningHallViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ScreeningHallViewController.h"
#import "videoTitleViewModel.h"
#import "videoTitleModel.h"
#import "ljwcodePageViewController.h"

@interface ScreeningHallViewController ()<ljwcodePageViewControllerDelegate,ljwcodePageViewControllerDataSource>

@property(nonatomic,strong)videoTitleViewModel *titleViewModle;

@property(nonatomic,strong)NSMutableArray *titleArray;

@end

@implementation ScreeningHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ljwcodePageViewController *pageVC = [[ljwcodePageViewController alloc]initWithConfig:[ljwcodePageViewControllerConfig defaultConfig]];
    pageVC.delegate = self;
    pageVC.dataSource = self;
    pageVC.view.frame = self.view.bounds;
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
       
       @weakify(self)
       [[self.titleViewModle.videoCommand execute:@18] subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           self.titleArray = x;
//           [self reloadData];
           [self PageMenuView];
       }];
       
       self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)PageMenuView{

//    @weakify(self)
//    [RACObserve(self.scrollView, contentOffset) subscribeNext:^(id x) {
//        @strongify(self);
//        CGPoint offset = [x CGPointValue];
//        if (offset.x > [UIScreen mainScreen].bounds.size.width * (self.titleArray.count - 1)) {
//            self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * (self.titleArray.count - 1), 0);
//        }
//    }];
    
}

//#pragma mark - WMPageController delelgate && datasource
//-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
//    if(self.titleArray.count == 0||!_titleArray){
//        return 0;
//    }
//    return self.titleArray.count+1;
//}
////设置每一个分页栏展示的控制器及内容
//- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
//
//    return [[UIViewController alloc]init];
////    if (index > self.titleArray.count - 1) {
////        return  [[ScreenHallXGVideoDetailViewController alloc]init];
////    }
////    videoTitleModel *model = self.titleArray[index];
////    ScreenHallXGVideoDetailViewController *detail = [[ScreenHallXGVideoDetailViewController alloc]init];
////    detail.titleModel = model;
////    return detail;
//
//}
////设置每一个channel的title
//-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
//    if (index > self.titleArray.count - 1) {
//        return @"       ";
//    }else {
//        videoTitleModel *model = self.titleArray[index];
//        return model.name;
//    }
//}

#pragma mark ------- ljwcodePageViewControllerDelegate && ljwcodePageViewControllerDataSource

-(UIViewController *)pageViewController:(ljwcodePageViewController *)pageViewcontroller viewControllerAtIndex:(NSInteger)index {
    return [[UIViewController alloc]init];
}

-(NSString *)pageViewController:(ljwcodePageViewController *)pageViewController titleAtIndex:(NSInteger)index {
    if(index > self.titleArray.count - 1){
        return  @" " ;
    }else {
        videoTitleModel *titleModel = self.titleArray[index];
        return titleModel.name;
    }
}

-(NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

-(void)pageViewController:(ljwcodePageViewController *)pageViewcontroller didSelectedIndex:(NSInteger)index {
    [pageViewcontroller reloadData];
    videoTitleModel *titleModel = self.titleArray[index];
    NSLog(@"切换到了%@",titleModel.name);
}


#pragma mark - MenuViewDelegate

//-(void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
//    if(index == -1){
//        [self needRefreshTableViewData];
//    }else{
//        [super menuView:menu didSelesctedIndex:index currentIndex:currentIndex];
//    }
    
//}

-(videoTitleViewModel *)titleViewModle{
    if(!_titleViewModle){
        _titleViewModle = [[videoTitleViewModel alloc]init];
    }
    return _titleViewModle;
}

-(void)needRefreshTableViewData{
//    ScreenHallXGVideoDetailViewController *videoDetailVC = (ScreenHallXGVideoDetailViewController *)self.currentViewController;
//    [videoDetailVC needRefreshTableViewData];
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
