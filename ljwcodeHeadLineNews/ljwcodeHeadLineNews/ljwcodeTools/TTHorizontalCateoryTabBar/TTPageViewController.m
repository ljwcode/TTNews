//
//  TTPageViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPageViewController.h"
#import <Masonry/Masonry.h>

@interface TTPageViewController ()<TTPageMenuViewDelegate,TTPageControllerDataSource,UIPageViewControllerDelegate,UIPageViewControllerDataSource,TTPageMenuViewDelegate,TTPageMenuViewDataSource>

@property(nonatomic,strong)UIPageViewController *pageViewController;

@property(nonatomic,strong)TTPageMenuView *menuView;

@property(nonatomic,weak)UIViewController *navBarController;

@property(nonatomic,assign)NSInteger dataCount;

@property(nonatomic,assign)BOOL isDragPageContrller;


@end

@implementation TTPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(instancetype)initWithMenuNavBarController:(UIViewController *)navBarController{
    if(self = [super init]){
        _navBarController = navBarController;
        [self.view addSubview:self.menuView];
        [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.mas_equalTo(self.view);
            make.height.mas_equalTo(self.menuView.menuSize.height);
        }];
        [self.view addSubview:self.pageViewController.view];
        [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(self.menuView.mas_bottom);
        }];
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.menuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.menuView.menuSize.height);
    }];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    UIPageViewControllerNavigationDirection direction = selectIndex > self.selectIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    _selectIndex = selectIndex;
    if (self.dataCount == 0) { return; }
    NSAssert(self.selectIndex <= (self.dataCount - 1), @"选中的下标超出了范围");
    [self.menuView selectedItemAtIndex:selectIndex withAnimation:YES];
    UIViewController *vc = [self.dataSource pageController:self viewContrlllerAtIndex:selectIndex];
    [self.pageViewController setViewControllers:@[vc] direction:direction animated:YES completion:nil];
}

- (void)setMenuBackgroundColor:(UIColor *)menuBackgroundColor {
    _menuBackgroundColor = menuBackgroundColor;
    self.menuView.backgroundColor = menuBackgroundColor;
}

- (void)setMenuItemSize:(CGSize)menuItemSize {
    _menuItemSize = menuItemSize;
    self.menuView.menuSize = menuItemSize;
    if (self.dataCount == 0) { return; }
    [self.menuView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.menuView.menuSize.height);
    }];
}

- (void)setDecorateSize:(CGSize)decorateSize {
    _decorateSize = decorateSize;
    self.menuView.decorateSize = decorateSize;
}

- (void)setDecorateColor:(UIColor *)decorateColor {
    _decorateColor = decorateColor;
    self.menuView.decorateColor = decorateColor;
}

- (void)setMenuSize:(CGSize)menuSize {
    _menuSize = menuSize;
    self.menuView.frame = CGRectMake(0, 0, menuSize.width, menuSize.height);
}

- (void)setMenuBorderWidth:(CGFloat)menuBorderWidth {
    _menuBorderWidth = menuBorderWidth;
    self.menuView.layer.borderWidth = menuBorderWidth;
}

- (void)setMenuBorderColor:(UIColor *)menuBorderColor {
    _menuBorderColor = menuBorderColor;
    self.menuView.layer.borderColor = menuBorderColor.CGColor;
}

- (void)setMenuCornerRadius:(CGFloat)menuCornerRadius {
    _menuCornerRadius = menuCornerRadius;
    self.menuView.layer.cornerRadius = menuCornerRadius;
}

#pragma mark -- lazy load

-(TTPageMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[TTPageMenuView alloc] init];
        _menuView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _menuView.delegate = self;
        _menuView.dataSource = self;
    }
    return _menuView;
}

-(UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self addChildViewController:_pageViewController];
    }
    return _pageViewController;
}

-(NSInteger)dataCount{
    return [self.dataSource numbersOfViewControllerInPageController:self];
}

#pragma mark - TTMenuView DataSource & Delegate

-(NSInteger)numbersOfItemsInMenuView:(TTPageMenuView *)menuView{
    return self.dataCount;
}

-(TTPageMenuItem *)menuView:(TTPageMenuView *)menuView menuCellForItemAtIndex:(NSInteger)index{
    return [self.dataSource pageController:self menuView:menuView menuItemAtIndex:index];
}

- (UIView *)decorateItemInMenuView:(TTPageMenuView *)menuView {
    if ([self.dataSource respondsToSelector:@selector(decorateItemInPageController:menuView:)]) {
        return [self.dataSource decorateItemInPageController:self menuView:menuView];
    }
    return nil;
}

- (void)menuView:(TTPageMenuView *)menuView didSelectIndex:(NSInteger)index {
    if (!self.isDragPageContrller) {
        __weak typeof(self)weakSelf = self;
        UIViewController *vc = [self.dataSource pageController:self viewContrlllerAtIndex:index];
        if (vc == nil) { return; }
        
        NSInteger beforeSelectIndex = self.selectIndex;
        _selectIndex = index;
        [self willEnterViewController];
        if (self.selectIndex == 0 && self.selectIndex == beforeSelectIndex) {
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                [weakSelf didEnterViewController];
            }];
        } else if (self.selectIndex > beforeSelectIndex) {
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
                [weakSelf didEnterViewController];
            }];
        } else {
            [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
                [weakSelf didEnterViewController];
            }];
        }
    }
    self.isDragPageContrller = NO;
}

#pragma mark - pageView dataSource & delagate

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.dataSource indexOfViewController:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index --;
    return [self.dataSource pageController:self viewContrlllerAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.dataSource indexOfViewController:viewController];
    if (index == self.dataCount - 1 || (index == NSNotFound)) {
        return nil;
    }
    index ++;
    return [self.dataSource pageController:self viewContrlllerAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    UIViewController *nextVC = [pendingViewControllers firstObject];
    NSInteger index = [self.dataSource indexOfViewController:nextVC];
    _selectIndex = index;
    [self willEnterViewController];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && finished) {
        self.isDragPageContrller = YES;
        [self.menuView selectedItemAtIndex:self.selectIndex withAnimation:YES];
        [self didEnterViewController];
    }
}

#pragma mark - private method

- (void)willEnterViewController {
    [self.delegate pageController:self willEnterViewControllerAtIndex:self.selectIndex];
}

- (void)didEnterViewController {
    [self.delegate pageController:self didEnterViewControllerAtIndex:self.selectIndex];
}

#pragma mark - public method

- (void)reloadData {
    if (self.selectIndex > (self.dataCount - 1)) {
        _selectIndex = 0;
    }
    [self.menuView reloadData];
    UIViewController *vc = [self.dataSource pageController:self viewContrlllerAtIndex:self.selectIndex];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
