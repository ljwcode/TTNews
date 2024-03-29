//
//  homeViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//
#import "homeViewController.h"
#import "channelButton.h"
#import <RACSubject.h>
#import "homeTitleViewModel.h"
#import "homeTableViewController.h"
#import "homeTitleDBViewModel.h"
#import "UIButton+extend.h"
#import <AFNetworkReachabilityManager.h>
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import <TTNews-Swift.h>

@interface homeViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)homeTitleViewModel *titleViewModle;

@property(nonatomic,strong)homeTitleDBViewModel *titleDb;

@end

@implementation homeViewController

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
        @weakify(self)
        [[self.titleViewModle.titleCommand execute:@13] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.titleArray = x;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [self.titleDb createTitleCacheDb];
                for(int i = 0;i < self.titleArray.count;i++){
                    homeTitleModel *model = self.titleArray[i];
                    [self.titleDb InsertDataWithDB:model];
                }
            });
            [self reloadData];
            fulfill(self.titleArray);
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self PageMenuView];
    
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.selectIndex = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
}

-(void)needRefreshTableViewData{
    homeTableViewController *detailVC = (homeTableViewController *)self.currentViewController;
    [detailVC needRefreshTableViewData];
}

#pragma mark ------ lazy load

-(homeTitleViewModel *)titleViewModle{
    if(!_titleViewModle){
        _titleViewModle = [[homeTitleViewModel alloc]init];
    }
    return _titleViewModle;
}

-(homeTitleDBViewModel *)titleDb{
    if(!_titleDb){
        _titleDb = [[homeTitleDBViewModel alloc]init];
    }
    return _titleDb;
}


#pragma mark -----  pageMenuView

-(void)PageMenuView{
    UIButton *addChannelBtn = UIButton.buttonType(UIButtonTypeCustom).showImage([UIImage imageNamed:@"add_channel_titlbar_thin_new"],UIControlStateNormal);
    addChannelBtn.backgroundColor = [UIColor whiteColor];
    addChannelBtn.frame = CGRectMake(kScreenWidth - 52, 0, 52, 35);
    addChannelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.menuView addSubview:addChannelBtn];
    
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
    if(self.titleArray.count == 0||!self.titleArray){
        return 0;
    }
    return self.titleArray.count+1;
}
//设置每一个分页栏展示的控制器及内容
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    if (index > self.titleArray.count - 1) {
        return  [[homeTableViewController alloc]init];
    }else if(index == 0){
        TT_followCategoryController *followCategoryVC = [[TT_followCategoryController alloc]init];
        return followCategoryVC;
    }
    homeTitleModel *model = self.titleArray[index];
    homeTableViewController *detial = [[homeTableViewController alloc]init];
    detial.titleModel = model;
    return detial;
    
}
//设置每一个channel的title
-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    if (index > self.titleArray.count - 1) {
        return @" ";
    }else {
        homeTitleModel *model = self.titleArray[index];
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
