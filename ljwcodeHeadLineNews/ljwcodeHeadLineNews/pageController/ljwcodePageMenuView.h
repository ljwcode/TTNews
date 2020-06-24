//
//  ljwcodePageMenuView.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *const ljwcodeMenuPageDataSourceKey NS_EXTENSIBLE_STRING_ENUM;

typedef CGFloat(^ljwcodeMenuPageDataSource) (void);

//
static ljwcodeMenuPageDataSourceKey const ljwcodeMenuPageLeftMargin = @"ljwcodeMenuPageLeftMargin";

static ljwcodeMenuPageDataSourceKey const ljwcodeMenuPageRightMargin = @"ljwcodeMenuPageRgihtMargin";

static ljwcodeMenuPageDataSourceKey const ljwcodeMenuPageItemIsAutoResizing = @"ljwcodeMenuPageItemIsAutoResizing";

static ljwcodeMenuPageDataSourceKey const ljwcodecodeMenuItemVerticalCenter = @"ljwcodeMenuItemVerticalCenter";

static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewItemPadding = @"ljwcodePageMenuViewItemPadding";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewItemTopPadding = @"ljwcodePageMenuViewItemTopPadding";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewItemHeight = @"ljwcodePageMenuViewItemHeight";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewItemWidth = @"ljwcodePageMenuViewItemWidth";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewHasUnderLine = @"ljwcodePageMenuViewHasUnderLine";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewNormalTitleColor = @"ljwcodePageMenuViewNormalTitleColor";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewSelectedTitleColor = @"ljwcodePageMenuViewSelectedTitleColor";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewTitleFont = @"ljwcodePageMenuViewTitleFont";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewSelectedTitleFont = @"ljwcodePageMenuViewSelectedTitleFont";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewLineColor = @"ljwcodePageMenuViewLineColor";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewItemTitlePadding = @"ljwcodePageMenuViewItemTitlePadding";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewLineTopPadding = @"ljwcodePageMenuViewLineTopPadding";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewLineHeight = @"ljwcodePageMenuViewLineHeight";
static ljwcodeMenuPageDataSourceKey const ljwcodePageMenuViewLineWidth = @"ljwcodePageMenuViewLineWidth";

@protocol ljwcodePageMenuDelegate<NSObject>

-(void)ljwcodePageMenuViewDidclickItemIndex:(NSInteger)index beforeIndex:(NSInteger)beforeIndex;

@end

@class ljwcodePageItem;
@interface ljwcodePageMenuView : UIScrollView

@property(nonatomic,copy)id<ljwcodePageMenuDelegate> pageMenuDelegate;

@property(nonatomic,copy)void(^pageMenuItemClick)(NSInteger currentIndex,NSInteger beforeIndex,ljwcodePageMenuView *menuView);

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)title dataSources:(NSDictionary<ljwcodeMenuPageDataSourceKey,id>*)dataSource;

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)scrollToPageItem:(ljwcodePageItem*)pageItem;

- (void)updateMenuViewWithNewItemArray:(NSArray *)items selectedIndex:(NSInteger)selectedIndex;

@property(nonatomic,assign)CGFloat leftMargin;

@property(nonatomic,assign)CGFloat rightMargin;

@property(nonatomic,assign)BOOL isAutoResizing;

@property(nonatomic,assign)BOOL isVerticalCenter;

@property(nonatomic,assign)CGFloat ItemPadding;

@property(nonatomic,assign)CGFloat ItemTopPadding;

@property(nonatomic,assign)CGFloat ItemHeight;

@property(nonatomic,assign)CGFloat ItemWidth;

@property(nonatomic,assign)BOOL hasUnderLine;

@property(nonatomic,strong)UIColor *NormalTitleColor;

@property(nonatomic,strong)UIColor *SelectedTitleColor;

@property(nonatomic,strong)UIFont *TitleFont;

@property(nonatomic,strong)UIFont *SelectedTitleFont;

@property(nonatomic,strong)UIColor *LineColor;

@property(nonatomic,assign)CGFloat ItemTitlePadding;

@property(nonatomic,assign)CGFloat LineTopPadding;

@property(nonatomic,assign)CGFloat LineHeight;

@property(nonatomic,assign)CGFloat LineWidth;

@property(nonatomic,assign)NSInteger pageScrollViewIndex;


@end

//设置item样式
@interface ljwcodePageItem : UIView

@property (nonatomic,strong)UIButton *button;

@property (nonatomic,assign)BOOL itemSelected;
/**
 文字两边的间距
 */
@property (nonatomic,assign)CGFloat padding;

/**
 自己计算宽度
 */
@property (nonatomic,assign)BOOL autoResizing;

/**
 按钮标题
 */
@property (nonatomic,copy)NSString *title;

/**
 常态item的字体颜色
 */
@property (nonatomic,strong)UIColor *normalTitleColor;
/**
 选中item的字体颜色
 */
@property (nonatomic,strong)UIColor *selectedTitleColor;
/**
 item的字体
 */
@property (nonatomic,strong)UIFont *titleFont;
/**
 选中Item的字体
 */
@property (nonatomic,strong)UIFont *selectedTitleFont;


//固定的宽度
-(instancetype)initWithFrame:(CGRect)frame widthAutoResizing:(BOOL)autoResizing title:(NSString*)title padding:(CGFloat)padding clicked:(void(^)(UIButton*button))itemClicked;

@end

NS_ASSUME_NONNULL_END
