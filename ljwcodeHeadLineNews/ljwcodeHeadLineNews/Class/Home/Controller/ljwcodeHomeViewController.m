//
//  ljwcodeHomeViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//
#import "ljwcodeHomeViewController.h"
#import "ljwcodeTabBarController.h"
#import "QiPageMenuView.h"
#import "QiPageContentView.h"
#import "ljwcodeBaseViewController.h"
#import "ljwcodeHeader.h"
#import "channelButton.h"
#import "NewsChannelView.h"
#import "newsChannelModel.h"
#import "homeTitleModel.h"
#import <RACSubject.h>
#import "homeTitleViewModel.h"

@interface ljwcodeHomeViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)homeTitleViewModel *titleViewModle;



@end

@implementation ljwcodeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self configurePageMenuView];
    ljwcodeNavigationBar *navBar = [self showNaviBar];
    
    [navBar.navigationBarActionSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    [self configureUI];
    @weakify(self)
    
    [[self.titleViewModle.titleCommand execute:@13] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.titleArray = x;
        [self reloadData];
        [self setPageMenuView];
    }];
    [navBar setLjwcodeActionCallBack:^(ljwcodeNavigationBarAction action) {
        @strongify(self);
        if(action != ljwcodeNavigationBarActionSend){
            
        }else{
            NSLog(@"send");
        }
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
        // Do any additional setup after loading the view from its nib.
}

-(homeTitleViewModel *)titleViewModle{
    if(!_titleViewModle){
        _titleViewModle = [[homeTitleViewModel alloc]init];
    }
    return _titleViewModle;
}

#pragma mark - setup pageMenuView1
-(void)configurePageMenuView{
    NSDictionary *dataSource = @{
                                 QiPageMenuViewNormalTitleColor : [UIColor blackColor],
                                 QiPageMenuViewSelectedTitleColor : [UIColor redColor],
                                 QiPageMenuViewTitleFont : [UIFont systemFontOfSize:14],
                                 QiPageMenuViewSelectedTitleFont : [UIFont systemFontOfSize:18],
                                 QiPageMenuViewItemIsVerticalCentred : @(YES),
                                 QiPageMenuViewItemTitlePadding : @(10.0),
                                 QiPageMenuViewItemTopPadding : @(10.0),
                                 QiPageMenuViewItemPadding : @(10.0),
                                 QiPageMenuViewLeftMargin : @(20.0),
                                 QiPageMenuViewRightMargin : @(20.0),
                                 QiPageMenuViewItemWidth : @(0.0),
                                 QiPageMenuViewItemsAutoResizing : @(YES),
                                 QiPageMenuViewItemHeight : @(40.0),
                                 QiPageMenuViewHasUnderLine :@(YES),
                                 QiPageMenuViewLineColor : [UIColor blackColor],
                                 QiPageMenuViewLineWidth : @(30.0),
                                 QiPageMenuViewLineHeight : @(4.0),
                                 QiPageMenuViewLineTopPadding : @(10.0)
                                 };
    UIViewController *ctrl = [UIViewController new];
    ctrl.view.backgroundColor = [UIColor blueColor];
    ctrl.edgesForExtendedLayout = UIRectEdgeNone;
    UIViewController *ctrl1 = [UIViewController new];
    ctrl1.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *ctrl2 = [UIViewController new];
    ctrl2.view.backgroundColor = [UIColor brownColor];
    
    UIViewController *ctrl3 = [UIViewController new];
    ctrl3.view.backgroundColor = [UIColor redColor];
    
    UIViewController *ctrl4 = [UIViewController new];
    ctrl4.view.backgroundColor = [UIColor greenColor];
    UIViewController *ctrl5 = [UIViewController new];
    ctrl3.view.backgroundColor = [UIColor redColor];
    
    UIViewController *ctrl6 = [UIViewController new];
    ctrl4.view.backgroundColor = [UIColor greenColor];
    
    QiPageMenuView *menuView = [[QiPageMenuView alloc]initWithFrame:CGRectMake(0, 80, self.view.width, 50) titles:@[@"系统消息",@"节日消息",@"广播通知",@"最新",@"最热",@"你好",@"你好呀"] dataSource:dataSource];
    menuView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:menuView];
    
    QiPageContentView *contenView = [[QiPageContentView alloc]initWithFrame:CGRectMake(0, menuView.bottom+10, self.view.width, self.view.height - menuView.bottom - 10 - 88-10) childViewController:@[ctrl,ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6]];
    [self.view addSubview:contenView];
    
    menuView.pageItemClicked = ^(NSInteger clickedIndex, NSInteger beforeIndex, QiPageMenuView *menu) {
        NSLog(@"点击了：之前：%ld 现在：%ld",beforeIndex,clickedIndex);
        [contenView setPageContentShouldScrollToIndex:clickedIndex beforIndex:beforeIndex];
    };
    
    contenView.pageContentViewDidScroll = ^(NSInteger currentIndex, NSInteger beforeIndex, QiPageContentView * _Nonnull pageView) {
        menuView.pageScrolledIndex = currentIndex;
        NSLog(@"滚动了：之前：%ld 现在：%ld",beforeIndex,currentIndex);
    };
    
}

-(void)configureUI{
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
}
#pragma mark - setup pageMenuViewStyle2
-(void)setPageMenuView{
    
    UIButton *addChannelBtn = UIButton.buttonType(UIButtonTypeCustom).showImage([UIImage imageNamed:@"add_channel_titlbar_thin_new_16x16_"],UIControlStateNormal).bgImage([UIImage imageNamed:@"shadow_add_titlebar_new3_52x36_"],UIControlStateNormal);
    addChannelBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-52, 0, 52, 35);
    addChannelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.menuView addSubview:addChannelBtn];
    
    [[addChannelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NewsChannelView *channelView = [[NewsChannelView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,kScreenHeight-kScreenStatusBarHeight )];
        [[UIApplication sharedApplication].keyWindow addSubview:channelView];
        [channelView channelShow];
    }];
    
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
//- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
//    newsChannelModel *model = self.titleArray[index];
//
//}

-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    if (index > self.titleArray.count - 1) {
        return @"       ";
    }else {
        homeTitleModel *model = self.titleArray[index];
        return model.name;
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
