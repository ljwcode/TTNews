//
//  ljwcodeTabBarController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeTabBarController.h"
#import "ljwcodeNavigationController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UITabBar+ljwcodeTabBarItem.h"
#import "ljwcodeHeader.h"
#import "homeViewController.h"
#import "ljwcodeWeiTouTiaoViewController.h"
#import "ljwcodeMineViewController.h"
#import "ljwcodeVideoViewController.h"


@interface ljwcodeTabBarController()<UITabBarControllerDelegate>

@property(nonatomic,weak)ljwcodeNavigationController *homeNavi;

@property(nonatomic,weak)UIImageView *selectedImageView;

@end

@implementation ljwcodeTabBarController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _homeNavi = [self addChildViewController:[homeViewController class] normalImage:@"home_tabbar_32x32_" selectedImage:@"home_tabbar_press_32x32_" title:@"首页"];
    [self addChildViewController:[ljwcodeVideoViewController class] normalImage:@"video_tabbar_32x32_" selectedImage:@"video_tabbar_press_32x32_" title:@"西瓜视频"];
    [self addChildViewController:[ljwcodeWeiTouTiaoViewController class] normalImage:@"weitoutiao_tabbar_32x32_" selectedImage:@"weitoutiao_tabbar_press_32x32" title:@"微头条"];
    [self addChildViewController:[ljwcodeMineViewController class] normalImage:@"huoshan_tabbar_32x32_" selectedImage:@"huoshan_tabbar_press_32x32_" title:@"我"];
    
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
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"home_tabbar_32x32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_press_32x32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

+(void)initialize
{
    
    [[UITabBar appearance]setTranslucent:NO];
    [[UITabBar appearance]setBarTintColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    
//    normal
    UITabBarItem *item = [UITabBarItem appearance];

    item.titlePositionAdjustment = UIOffsetMake(0, -5);//titile 和 image的位置
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSFontAttributeName] = [UIFont systemFontOfSize:10.f];
    normalDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    
    //selected
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    selectedDic[NSFontAttributeName] = [UIFont systemFontOfSize:10.f];
    selectedDic[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.97 green:0.35 blue:0.35 alpha:1];
    [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];

}

-(ljwcodeNavigationController *)addChildViewController:(Class)class normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    UIViewController *VC = [[class alloc]init];
    ljwcodeNavigationController *nav = [[ljwcodeNavigationController alloc]initWithRootViewController:VC];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:normalImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    return nav;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if(self.selectedViewController == viewController && self.selectedViewController == _homeNavi)
    {
        if([self.selectedImageView.layer animationForKey:@"rotationAnimation"])
        {
            return YES;
        }
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"home_tabber_loading_32*32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabber_loading_32*32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        self.homeNavi.tabBarItem.image = [[UIImage imageNamed:@"home_tabbar_32x32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.homeNavi.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_tabbar_press_32x32_"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if(self.selectedViewController == viewController)
    {
        ljwcodeNavigationController *Navi = (ljwcodeNavigationController *)viewController;
        if([Navi.viewControllers.firstObject respondsToSelector:@selector(needRefreshTableViewData)])
        {
//            [Navi.viewControllers.firstObject needRefreshTableViewData];
        }
    }
    
    
    return YES;
}





@end
