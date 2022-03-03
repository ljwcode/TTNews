//
//  ljwcodePageBasicTitleView.h
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/15.
//

#import <UIKit/UIKit.h>
#import "ljwcodePageTitleCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ljwcodePageBasicTitleViewDelegate<NSObject>

-(BOOL)pageTitleViewDidSelectedAtIndex:(NSInteger)index;

@end

@protocol ljwcodePageBasicTitleViewDatasource <NSObject>

-(NSString *)pageTitleViewTitleAtIndex:(NSInteger)index;

-(NSInteger)pageTitleViewNumberOfTitle;

-(ljwcodePageTitleCollectionViewCell *)pageTitleViewCellForItemAtIndex:(NSInteger)index;

@end

@interface ljwcodePageBasicTitleView : UIView

@property(nonatomic,weak)id<ljwcodePageBasicTitleViewDelegate> delegate;

@property(nonatomic,weak)id<ljwcodePageBasicTitleViewDatasource> dataSource;

@property(nonatomic,assign)NSInteger selectedIndex;

@property(nonatomic,assign)NSInteger lastSelectedIndex;

@property(nonatomic,assign)CGFloat animationProgress;

@property(nonatomic,assign)BOOL stopAnimation;

@property(nonatomic,strong)UIButton *rightBtn;

-(instancetype)initWithConfig:(ljwcodePageViewControllerConfig *)config;

-(void)registerClass:(Class)class cellForTitleWithResuseIdentifier:(NSString *)identifier;

-(ljwcodePageTitleCollectionViewCell *)dequeueResuseIdentifier:(NSString *)identifier forIndex:(NSInteger)index;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
