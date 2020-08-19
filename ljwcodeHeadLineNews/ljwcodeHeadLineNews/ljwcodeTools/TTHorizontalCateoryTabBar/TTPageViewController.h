//
//  TTPageViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTPageMenuView.h"

NS_ASSUME_NONNULL_BEGIN
@class TTPageViewController;

@protocol TTPageControllerDataSource <NSObject>
@required

-(NSInteger)numbersOfViewControllerInPageController:(TTPageViewController *)pageController;

-(NSInteger)indexOfViewController:(UIViewController *)viewController;

-(UIViewController *)pageController:(TTPageViewController *)pageController viewContrlllerAtIndex:(NSInteger)index;

-(TTPageMenuItem *)pageController:(TTPageViewController *)pageController menuView:(TTPageMenuView *)menuView menuItemAtIndex:(NSInteger)index;

@optional

-(UIView *)decorateItemInPageController:(TTPageViewController *)pageController menuView:(TTPageMenuView *)menuView;

@end

@protocol TTPageControllerDelegate <NSObject>

-(void)pageController:(TTPageViewController *)pageController willEnterViewControllerAtIndex:(NSInteger)index;

-(void)pageController:(TTPageViewController *)pageController didEnterViewControllerAtIndex:(NSInteger)index;

@end

@interface TTPageViewController : UIViewController

@property(nonatomic,weak)id<TTPageControllerDataSource>dataSource;

@property(nonatomic,weak)id<TTPageControllerDelegate>delegate;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,assign)CGSize menuItemSize;

@property(nonatomic,assign)CGSize decorateSize;

@property(nonatomic,strong)UIColor *decorateColor;

@property(nonatomic,strong)UIColor *menuBackgroundColor;

@property(nonatomic,assign)CGSize menuSize;

@property(nonatomic,assign)CGFloat menuBorderWidth;

@property(nonatomic,strong)UIColor *menuBorderColor;

@property(nonatomic,assign)CGFloat menuCornerRadius;

-(instancetype)initWithMenuNavBarController:(UIViewController *)navBarController;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
