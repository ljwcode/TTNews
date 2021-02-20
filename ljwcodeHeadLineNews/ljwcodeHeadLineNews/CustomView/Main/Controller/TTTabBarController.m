//
//  TTTabBarController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTNavigationController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UITabBar+TTTabBarItem.h"
#import "TTHeader.h"
#import "homeViewController.h"
#import "ScreeningHallViewController.h"
#import "MineViewController.h"
#import "XGVideoViewController.h"
#import "TT_tabBarViewModel.h"
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>
#import "TTTabBarItem.h"
#import "TTTabBar.h"
#import "TT_tabBarModel.h"

@interface TTTabBarController()<UITabBarControllerDelegate>{
    TTTabBar *tabBar;
}

@property(nonatomic,weak)TTNavigationController *homeNavi;

@property(nonatomic,weak)UIImageView *selectedImageView;

@property(nonatomic,strong)TT_tabBarViewModel *viewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TTTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self TT_TabBarPromise];
    
    self.delegate = self;
    
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.tabBar showBadgeWithItemIndex:0 bageNumber:18];//5秒后在首页显示18个红点
    });
    [[RACScheduler mainThreadScheduler]afterDelay:1.5*60 schedule:^{
        [self.tabBar showBadgeWithItemIndex:0 bageNumber:28];//1.5秒后显示28个红点
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:KHomeStopRefreshNot object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self.tabBar hideBadgeWithItemIndex:0];
        if(self.selectedImageView){
            [self.selectedImageView stopAnimating];
        }
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"new_home_tabbar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"new_home_tabbar_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarViewHeight) name:TabBarViewHeight object:nil];
    
}

-(void)addRooTViewController{
    CGFloat itemH = TT_USERDEFAULT_float(TabBarViewHeight);
    tabBar = [[TTTabBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - itemH, kScreenWidth, itemH)];
    [self setValue:tabBar forKey:@"tabBar"];
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < self.dataArray.count;i++){
        TT_tabBarModel *model = self.dataArray[i];
        TTTabBarItem *item = [[TTTabBarItem alloc]initWithItemTitle:model.titleName normalImg:model.normalImg selectedImg:model.selectedImg];
        [array addObject:item];
    }
    tabBar.tabBarItemArray = [NSMutableArray arrayWithArray:array];
    homeViewController *homeVC = [[homeViewController alloc]init];
    TTNavigationController *homeNav = [[TTNavigationController alloc]initWithRootViewController:homeVC];
    
    XGVideoViewController *videoVC = [[XGVideoViewController alloc]init];
    TTNavigationController *videoNav = [[TTNavigationController alloc]initWithRootViewController:videoVC];
    
    ScreeningHallViewController *screenHallVC = [[ScreeningHallViewController alloc]init];
    TTNavigationController *screenHallNav = [[TTNavigationController alloc]initWithRootViewController:screenHallVC];
    
    MineViewController *mineVC = [[MineViewController alloc]init];
    TTNavigationController *mineNav = [[TTNavigationController alloc]initWithRootViewController:mineVC];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeNav,videoNav,screenHallNav,mineNav, nil];
    self.viewControllers = viewControllers;
    
}

-(void)TT_TabBarPromise{
    [[FBLPromise do:^id _Nullable{
        return [self TT_getTabBarDataModel];
    }] then:^id _Nullable(id  _Nullable value) {
        return [self TT_TabBarItem:value];
    }];
}

-(FBLPromise *)TT_getTabBarDataModel{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        [[self.viewModel.tabBarCommand execute:@"tabBar"]subscribeNext:^(id  _Nullable x) {
            NSMutableArray *array = (NSMutableArray *)x;
            self.dataArray = array;
            fulfill(self.dataArray);
        }];
    }];
}

-(FBLPromise *)TT_TabBarItem:(id)dataArray{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        self.dataArray = dataArray;
        [self addRooTViewController];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

+(void)initialize{
    [[UITabBar appearance]setTranslucent:NO];
    [[UITabBar appearance]setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [tabBar setCurrentIndex:tabBarController.selectedIndex];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if(self.selectedViewController == viewController && self.selectedViewController == self.homeNavi){
        if([self.selectedImageView.layer animationForKey:@"rotationAnimation"]){
            return YES;
        }
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"home_tabbar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"home_tabbar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if(self.selectedViewController == viewController){
        TTNavigationController *Navi = (TTNavigationController *)viewController;
        if([Navi.viewControllers.firstObject respondsToSelector:@selector(needRefreshTableViewData)]){
            [Navi.viewControllers.firstObject needRefreshTableViewData];
        }
    }
    
    return YES;
}

- (void)viewWillLayoutSubviews{
    CGRect tabFrame = self.tabBar.frame;
    tabFrame.size.height = TT_USERDEFAULT_float(TabBarViewHeight);
    tabFrame.origin.y = self.view.frame.size.height - TT_USERDEFAULT_float(TabBarViewHeight);
    self.tabBar.frame = tabFrame;
}

#pragma mark ---- lazy load
-(TT_tabBarViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[TT_tabBarViewModel alloc]init];
    }
    return _viewModel;
}

-(void)tabBarViewHeight{
    CGFloat itemH = TT_USERDEFAULT_float(TabBarViewHeight);
    tabBar = [[TTTabBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - itemH, kScreenWidth, itemH)];
}

@end
