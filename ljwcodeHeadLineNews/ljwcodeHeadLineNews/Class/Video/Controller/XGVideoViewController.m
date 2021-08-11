//
//  XGVideoViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "XGVideoViewController.h"
#import "videoTitleViewModel.h"
#import "XGVideoTableViewController.h"
#import "videoTitleModel.h"
#import "videoTitleDBViewModel.h"
#import <AFNetworkReachabilityManager.h>
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>

@interface XGVideoViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong)videoTitleViewModel *titleViewModle;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)videoTitleDBViewModel *titleDBViewModel;

@end

@implementation XGVideoViewController

-(instancetype)init{
    if(self = [super init]){
        [self TT_titleArray];
    }
    return self;
}

-(void)TT_titleArray{
    [FBLPromise do:^id _Nullable{
        return [self getTitleModelDataArray];
    }];
}

-(FBLPromise *)getTitleModelDataArray{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        if([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable || [self.titleDBViewModel DBTableIsExists]){
            NSArray *array = [self.titleDBViewModel queryDataBase];
            for(int i = 0;i < array.count;i++){
                homeTitleModel *model = array[i];
                [self.titleArray addObject:model];
            }
            fulfill(self.titleArray);
        }else{
            @weakify(self)
            [[self.titleViewModle.videoCommand execute:@13] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                self.titleArray = x;
                [self.titleDBViewModel createDBCacheTable];
                for(int i = 0;i < self.titleArray.count;i++){
                    videoTitleModel *model = self.titleArray[i];
                    [self.titleDBViewModel InsertDBWithModel:model];
                }
                [self reloadData];
                fulfill(self.titleArray);
            }];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.selectIndex = 1;
    
    [self reloadData];
    [self PageMenuView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)PageMenuView{
    @weakify(self)
    [RACObserve(self.scrollView, contentOffset) subscribeNext:^(id x) {
        @strongify(self);
        CGPoint offset = [x CGPointValue];
        if (offset.x > kScreenWidth * (self.titleArray.count - 1)) {
            self.scrollView.contentOffset = CGPointMake(kScreenWidth * (self.titleArray.count - 1), 0);
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
        return  [[XGVideoTableViewController alloc]init];
    }
    videoTitleModel *model = self.titleArray[index];
    XGVideoTableViewController *detail = [[XGVideoTableViewController alloc]init];
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

#pragma mark ----- lazy load

-(NSMutableArray *)titleArray{
    if(!_titleArray){
        _titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
}

-(videoTitleDBViewModel *)titleDBViewModel{
    if(!_titleDBViewModel){
        _titleDBViewModel = [[videoTitleDBViewModel alloc]init];
    }
    return _titleDBViewModel;
}

-(videoTitleViewModel *)titleViewModle{
    if(!_titleViewModle){
        _titleViewModle = [[videoTitleViewModel alloc]init];
    }
    return _titleViewModle;
}

-(void)needRefreshTableViewData{
    XGVideoTableViewController *videoDetailVC = (XGVideoTableViewController *)self.currentViewController;
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
