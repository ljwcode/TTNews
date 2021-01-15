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
#import "VideoViewController.h"
#import "TTTabBarView.h"
#import "TT_tabBarViewModel.h"
#import <FBLPromises/FBLPromises.h>
#import <FBLPromises/FBLPromise.h>

@interface TTTabBarController()<UITabBarControllerDelegate>

@property(nonatomic,weak)TTNavigationController *homeNavi;

@property(nonatomic,weak)UIImageView *selectedImageView;

@property(nonatomic,strong)TT_tabBarViewModel *viewModel;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)TTTabBarView *tabBarView;

@end

@implementation TTTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TTFontChangeHandle) name:TT_ALL_FONT_CHANGE object:nil];
//    [self.view addSubview:self.tabBarView];
//    [self TT_TabBarPromise];

    _homeNavi = [self addChildViewController:[homeViewController class] normalImage:@"new_home_tabbar" selectedImage:@"new_home_tabbar_press" title:@"首页"];
    [self addChildViewController:[VideoViewController class] normalImage:@"video_tabbar" selectedImage:@"video_tabbar_press" title:@"西瓜视频"];
    [self addChildViewController:[ScreeningHallViewController class] normalImage:@"long_video_tabbar" selectedImage:@"long_video_tabbar_press" title:@"放映厅"];
    [self addChildViewController:[MineViewController class] normalImage:@"mine_tabbar" selectedImage:@"mine_tabbar_press" title:@"我"];
    
//    _homeNavi = [self TT_addChildViewController:[homeViewController class]];
//    [self TT_addChildViewController:[VideoViewController class]];
//    [self TT_addChildViewController:[ScreeningHallViewController class]];
//    [self TT_addChildViewController:[MineViewController class]];
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
        if(self.selectedImageView)
        {
            [self.selectedImageView stopAnimating];
        }
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"new_home_tabbar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"new_home_tabbar_press"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];

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
        [self.tabBarView TT_itemButton:4 itemBlock:^(NSInteger item) {
            self.selectedIndex = item - 100;
        } withDataArray:dataArray];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

+(void)initialize{
    
    [[UITabBar appearance]setTranslucent:NO];
    [[UITabBar appearance]setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
//    normal
    UITabBarItem *item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, -5);//titile 和 image的位置
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSFontAttributeName] = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    normalDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    
    //selected
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    selectedDic[NSFontAttributeName] = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    selectedDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.97 green:0.35 blue:0.35 alpha:1];
    [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    [item setTag:10010];

}

-(void)TTFontChangeHandle{
    
}

-(TTNavigationController *)addChildViewController:(Class)class normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    UIViewController *VC = [[class alloc]init];
    TTNavigationController *nav = [[TTNavigationController alloc]initWithRootViewController:VC];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:normalImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    return nav;
}

-(TTNavigationController *)TT_addChildViewController:(Class)class{
    UIViewController *VC = [[class alloc]init];
    TTNavigationController *nav = [[TTNavigationController alloc]initWithRootViewController:VC];
    [self addChildViewController:nav];
    return nav;
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

    tabFrame.size.height = 83;

    tabFrame.origin.y = self.view.frame.size.height - 83;

    self.tabBar.frame = tabFrame;
}

#pragma mark ---- lazy load
-(TT_tabBarViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[TT_tabBarViewModel alloc]init];
    }
    return _viewModel;
}

-(TTTabBarView *)tabBarView{
    if(!_tabBarView){
        _tabBarView = [[TTTabBarView alloc]init];
        [_tabBarView setFrame: CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49)];
    }
    return _tabBarView;
}

@end
