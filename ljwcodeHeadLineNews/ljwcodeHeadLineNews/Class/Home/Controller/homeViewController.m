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
#import "homeDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "homeTitleDBViewModel.h"

@interface homeViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)homeTitleViewModel *titleViewModle;

@property(nonatomic,strong)homeTitleDBViewModel *titleDb;

@end

@implementation homeViewController

//-(instancetype)init{
//    if(self = [super init]){
//        if([self.titleDb DBTableISExist]){
//            self.titleArray = [self.titleDb queryDBWithTitle];
//        }else{
//            @weakify(self)
//            [[self.titleViewModle.titleCommand execute:@13] subscribeNext:^(id  _Nullable x) {
//                @strongify(self);
//                self.titleArray = x;
//                [self.titleDb createTitleCacheDb];
//                for(int i = 0;i < self.titleArray.count;i++){
//                    homeTitleModel *model = self.titleArray[i];
//                    [self.titleDb InsertDataWithDB:model];
//                }
//                [self reloadData];
//            }];
//        }
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self PageMenuView];
    [self configureUI];
    self.view.backgroundColor = [UIColor whiteColor];
    @weakify(self)
    [[self.titleViewModle.titleCommand execute:@13] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.titleArray = x;
//        [self.titleDb createTitleCacheDb];
//        for(int i = 0;i < self.titleArray.count;i++){
//            homeTitleModel *model = self.titleArray[i];
//            [self.titleDb InsertDataWithDB:model];
//        }
        [self reloadData];
    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)needRefreshTableViewData{
    homeDetailViewController *detailVC = (homeDetailViewController *)self.currentViewController;
    [detailVC needRefreshTableViewData];
}

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

-(void)configureUI{
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
    self.selectIndex = 0;
}

#pragma mark -----  pageMenuView

-(void)PageMenuView{
    UIButton *addChannelBtn = UIButton.buttonType(UIButtonTypeCustom).showImage([UIImage imageNamed:@"add_channel_titlbar_thin_new"],UIControlStateNormal).bgImage([UIImage imageNamed:@"shadow_add_titlebar_new3_52x36_"],UIControlStateNormal);
    
    addChannelBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-52, 0, 52, 35);
    addChannelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.menuView addSubview:addChannelBtn];
    
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
    if(self.titleArray.count == 0||!self.titleArray){
        return 0;
    }
    return self.titleArray.count+1;
}
//设置每一个分页栏展示的控制器及内容
- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    
    if (index > self.titleArray.count - 1) {
        return  [[homeDetailViewController alloc]init];
    }
    homeTitleModel *model = self.titleArray[index];
    homeDetailViewController *detial = [[homeDetailViewController alloc]init];
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
