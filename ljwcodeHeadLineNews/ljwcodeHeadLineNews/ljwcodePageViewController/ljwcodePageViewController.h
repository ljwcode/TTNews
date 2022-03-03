//
//  ljwcodePageViewController.h
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/14.
//

#import <UIKit/UIKit.h>
#import "ljwcodePageViewControllerUtil.h"
#import "ljwcodePageViewControllerConfig.h"
#import "ljwcodePageTitleCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class ljwcodePageViewController;

@class ljwcodePageView;

@protocol ljwcodePageViewControllerDelegate <NSObject>
@required
-(void)pageViewController:(ljwcodePageViewController *)pageViewcontroller didSelectedIndex:(NSInteger)index;

@end

@protocol ljwcodePageViewControllerDataSource <NSObject>

@required

-(UIViewController *)pageViewController:(ljwcodePageViewController *)pageViewcontroller viewControllerAtIndex:(NSInteger)index;


-(NSString *)pageViewController:(ljwcodePageViewController *)pageViewController titleAtIndex:(NSInteger)index;

-(NSInteger)pageViewControllerNumberOfPage;

@optional
-(ljwcodePageTitleCollectionViewCell *)pageViewCOntroller:(ljwcodePageViewController *)pageViewController titleViewCellForItemAtIndex:(NSInteger)index;


@end

@protocol ljwcodePageViewDelegate <NSObject>

@required

-(void)pageView:(ljwcodePageView *)pageView didSelectIndex:(NSInteger)index;

@end

@protocol ljwcodePageViewDataSource <NSObject>

@required

-(UIView *)pageView:(ljwcodePageView *)pageView viewAtIndex:(NSInteger)index;

-(NSString *)pageView:(ljwcodePageView *)pageView titleAtIndex:(NSInteger)index;

-(NSInteger)pageViewControllerNumberOfPage;

@optional


@end

@interface ljwcodePageViewController : UIViewController

@property(nonatomic,weak)id<ljwcodePageViewControllerDelegate> delegate;

@property(nonatomic,weak)id<ljwcodePageViewControllerDataSource> dataSource;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,assign)BOOL scrollEnable;

@property(nonatomic,assign)BOOL bounces;

@property(nonatomic,strong)NSArray<NSString *> *otherGestureDelegateClassArray;

@property(nonatomic,strong)UIButton *rightBtn;

-(void)registerClasss:(Class)cellClass registerTitleViewCellWithResuseIdentifier:(NSString *)identifier;

-(ljwcodePageTitleCollectionViewCell *)dequeueReusableTitleViewCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

-(instancetype)initWithConfig:(ljwcodePageViewControllerConfig *)config;

-(void)reloadData;

@end

@interface ljwcodePageView : UIView

@property(nonatomic,weak)id<ljwcodePageViewDelegate> delegate;

@property(nonatomic,weak)id<ljwcodePageViewDataSource> dataSource;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,assign)BOOL scrollEnable;

@property(nonatomic,assign)BOOL bounces;

@property(nonatomic,strong)NSArray<NSString *> *otherGestureDelegateClassArray;

@property(nonatomic,strong)UIButton *rightBtn;

-(instancetype)initWithConfig:(ljwcodePageViewConfig *)config;

@end

NS_ASSUME_NONNULL_END
