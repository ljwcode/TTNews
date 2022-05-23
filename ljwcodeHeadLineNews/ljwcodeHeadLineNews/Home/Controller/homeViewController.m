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
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import <TTNews-Swift.h>
#import "ljwcodePageViewController.h"

@interface homeViewController ()<ljwcodePageViewControllerDelegate,ljwcodePageViewControllerDataSource>{
    NSString *saveControllerIdentifier;
}

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)homeTitleViewModel *titleViewModle;

@property(nonatomic,strong)homeTitleDBViewModel *titleDb;

@property(nonatomic,strong)ljwcodePageViewController *pageVC;

@end

@implementation homeViewController

-(instancetype)init{
    if(self = [super init]){
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"isNotInternet"]){
            NSLog(@"无网络缓存");
            [self TT_getDbCacheHomeTitle];
        }else {
            [self TT_titleArray];
            NSLog(@"有网络");
        }
    }
    return self;
}

-(void)TT_getDbCacheHomeTitle{
    self.titleArray = [self.titleDb queryDataBase];
    [self createPageMenu];
    for(int i = 0;i < self.titleArray.count;i++){
        homeTitleModel *model = self.titleArray[i];
        NSLog(@"model = %@",model.name);
    }
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
                    for(int i = 0;i < self.titleArray.count;i++){
                        homeTitleModel *model = self.titleArray[i];
                        if(![[NSUserDefaults standardUserDefaults]objectForKey:@"isSaveHomeTitle"]){
                            if(![self.titleDb DBTableISExist]){
                                [self.titleDb createTitleCacheDb];
                            }
                            [self.titleDb InsertDataWithDB:model];
                        }
                    }
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isSaveHomeTitle"];
            });
            [self createPageMenu];
            fulfill(self.titleArray);
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRestorationIdentifier:NSStringFromClass([self class])];
    [self setRestorationClass:self.class];
    // Do any additional setup after loading the view from its nib.
}

-(void)createPageMenu{
    self.pageVC = [[ljwcodePageViewController alloc]initWithConfig:[ljwcodePageViewControllerConfig defaultConfig]];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    self.pageVC.view.frame = self.view.bounds;
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}

-(void)needRefreshTableViewData{
    homeTableViewController *detailVC = (homeTableViewController *)self.getCurrentViewController;
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

#pragma mark ------ ljwcodePageViewControllerDelegate && ljwcodePageViewControllerDataSource

-(UIViewController *)pageViewController:(ljwcodePageViewController *)pageViewcontroller viewControllerAtIndex:(NSInteger)index {
    if(index > self.titleArray.count - 1){
        return [[homeTableViewController alloc]init];
    }else if(index == 0){
        TT_followCategoryController *followCategoryVC = [[TT_followCategoryController alloc]init];
        return followCategoryVC;
    }
    homeTitleModel *titleModel = self.titleArray[index];
    homeTableViewController *tableDetailVC = [[homeTableViewController alloc]init];
    tableDetailVC.titleModel = titleModel;
    
    return tableDetailVC;
}

-(NSString *)pageViewController:(ljwcodePageViewController *)pageViewController titleAtIndex:(NSInteger)index {
    if(index > self.titleArray.count - 1){
        return  @" " ;
    }else {
        homeTitleModel *titleModel = self.titleArray[index];
        return titleModel.name;
    }
}

-(NSInteger)pageViewControllerNumberOfPage {
    return self.titleArray.count;
}

-(void)pageViewController:(ljwcodePageViewController *)pageViewcontroller didSelectedIndex:(NSInteger)index {
    [pageViewcontroller reloadData];
    homeTitleModel *titleModel = self.titleArray[index];
    NSLog(@"切换到了%@",titleModel.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------ 试图状态恢复

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
}


-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
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
