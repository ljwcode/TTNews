//
//  ljwcodeHomeViewController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//
#import "ljwcodeHomeViewController.h"
#import "ljwcodeTabBarController.h"
#import "ljwcodePageContentView.h"
#import "ljwcodePageMenuView.h"

@interface ljwcodeHomeViewController ()

@end

@implementation ljwcodeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurePageMenuView];
    self.view.backgroundColor = [UIColor whiteColor];
        // Do any additional setup after loading the view from its nib.
}

-(void)configurePageMenuView{
    NSDictionary *dataSource = @{
                                 ljwcodePageMenuViewNormalTitleColor : [UIColor blackColor],
                                 ljwcodePageMenuViewSelectedTitleColor : [UIColor redColor],
                                 ljwcodePageMenuViewTitleFont : [UIFont systemFontOfSize:14],
                                 ljwcodePageMenuViewSelectedTitleFont : [UIFont systemFontOfSize:18],
                                 ljwcodecodeMenuItemVerticalCenter : @(YES),
                                 ljwcodePageMenuViewItemTitlePadding : @(10.0),
                                 ljwcodePageMenuViewItemTopPadding : @(10.0),
                                 ljwcodePageMenuViewItemPadding : @(10.0),
                                 ljwcodeMenuPageLeftMargin : @(20.0),
                                 ljwcodeMenuPageRightMargin : @(20.0),
                                 ljwcodePageMenuViewItemWidth : @(0.0),
                                 ljwcodeMenuPageItemIsAutoResizing : @(YES),
                                 ljwcodePageMenuViewItemHeight : @(40.0),
                                 ljwcodePageMenuViewHasUnderLine :@(YES),
                                 ljwcodePageMenuViewLineColor : [UIColor blackColor],
                                 ljwcodePageMenuViewLineWidth : @(30.0),
                                 ljwcodePageMenuViewLineHeight : @(4.0),
                                 ljwcodePageMenuViewLineTopPadding : @(10.0)
                                 };
    UIViewController *viewControllerl = [UIViewController new];
    viewControllerl.view.backgroundColor = [UIColor blueColor];
    viewControllerl.edgesForExtendedLayout = UIRectEdgeNone;
    UIViewController *viewControllerl1 = [UIViewController new];
    viewControllerl1.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *viewControllerl2 = [UIViewController new];
    viewControllerl2.view.backgroundColor = [UIColor brownColor];
    
    UIViewController *viewControllerl3 = [UIViewController new];
    viewControllerl3.view.backgroundColor = [UIColor redColor];
    
    UIViewController *viewControllerl4 = [UIViewController new];
    viewControllerl4.view.backgroundColor = [UIColor greenColor];
    UIViewController *viewControllerl5 = [UIViewController new];
    viewControllerl3.view.backgroundColor = [UIColor redColor];
    
    UIViewController *viewControllerl6 = [UIViewController new];
    viewControllerl4.view.backgroundColor = [UIColor greenColor];
    
    ljwcodePageMenuView *menuView = [[ljwcodePageMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50) titles:@[@"系统消息",@"节日消息",@"广播通知",@"最新",@"最热",@"你好",@"你好呀"] dataSources:dataSource];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuView];
    
    ljwcodePageContentView *contenView = [[ljwcodePageContentView alloc]initWithFrame:CGRectMake(0, menuView.bottom+10, self.view.width, self.view.height - menuView.bottom - 10 - 88-10) childViewController:@[viewControllerl,viewControllerl1,viewControllerl2,viewControllerl3,viewControllerl4,viewControllerl5,viewControllerl6]];
    [self.view addSubview:contenView];
    
    menuView.pageMenuItemClick = ^(NSInteger currentIndex, NSInteger beforeIndex, ljwcodePageMenuView * _Nonnull menuView) {
        NSLog(@"点击了：之前：%ld 现在：%ld",beforeIndex,currentIndex);
        [contenView pageContentViewScrollerToIndex:currentIndex beforeIndex:beforeIndex];
    };
    contenView.pageContentViewDidScroll = ^(NSInteger currentIndex, NSInteger beforeIndex, ljwcodePageContentView * _Nonnull contentView) {
        menuView.pageScrollViewIndex = currentIndex;
        NSLog(@"滚动了：之前：%ld 现在：%ld",beforeIndex,currentIndex);
    };
    
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
