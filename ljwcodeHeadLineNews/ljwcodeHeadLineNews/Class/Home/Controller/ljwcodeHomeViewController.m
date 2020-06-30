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
#import "homeDetailViewController.h"

@interface ljwcodeHomeViewController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)homeTitleViewModel *titleViewModle;



@end

@implementation ljwcodeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    //channel title 从网络中获取得到
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

-(void)configureUI{
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 10;
}
#pragma mark - setup pageMenuViewStyle2
-(void)setPageMenuView{
    
    UIButton *addChannelBtn = UIButton.buttonType(UIButtonTypeCustom).showImage([UIImage imageNamed:@"add_channel_titlbar_thin_new_16x16_"],UIControlStateNormal).bgImage([UIImage imageNamed:@"shadow_add_titlebar_new3_52x36_"],UIControlStateNormal);

    addChannelBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-52, 0, 52, 35);    addChannelBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.menuView addSubview:addChannelBtn];
    
    [[addChannelBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NewsChannelView *channelView = [[NewsChannelView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height == 812?44:20, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        [[UIApplication sharedApplication].keyWindow addSubview:channelView];
        [channelView channelShow];
    }];
    
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
    if(self.titleArray.count == 0||!_titleArray){
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

-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    if (index > self.titleArray.count - 1) {
        return @"       ";
    }else {
        homeTitleModel *model = self.titleArray[index];
        return model.name;
    }
}

#pragma mark - MenuViewDelegate

-(void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{
    [super menuView:menu didSelesctedIndex:index currentIndex:currentIndex];
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
