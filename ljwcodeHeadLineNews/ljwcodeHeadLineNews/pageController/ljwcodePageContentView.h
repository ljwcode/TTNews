//
//  ljwcodePageContentView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/23.
//  Copyright © 2020 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ljwcodePageContentViewDelegate<NSObject>

-(void)pageContentViewDidScrollerViewIndex:(NSInteger)index beforeIndex:(NSInteger)beforeIndex;

@end

@interface ljwcodePageContentView : UIView<UIPageViewControllerDataSource,UIScrollViewDelegate,ljwcodePageContentViewDelegate>


@property(nonatomic,strong)UIPageViewController *pageViewController;

@property(nonatomic,strong)NSArray *controllerArray;

//滑动代理回调
@property(nonatomic,copy)void(^pageContentViewDidScroll)(NSInteger currentIndex,NSInteger beforeIndex,ljwcodePageContentView *contentView);

@property(nonatomic,copy)id<ljwcodePageContentViewDelegate> delegate;

//滑动至某一控制器
-(void)pageContentViewScrollerToIndex:(NSInteger)index beforeIndex:(NSInteger)beforeIndex;

//初始化子控制器
- (instancetype)initWithFrame:(CGRect)frame childViewController:(NSArray*)childViewControllers;

@end

NS_ASSUME_NONNULL_END
