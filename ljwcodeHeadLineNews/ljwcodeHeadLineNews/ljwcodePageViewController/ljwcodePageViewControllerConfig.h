//
//  ljwcodePageViewControllerConfig.h
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ljwcodeTitleViewStyle){
    ljwcodeTitleViewStyleBasic = 0,
    ljwcodeTitleViewStyleSegmented = 1
};

typedef NS_ENUM(NSInteger,ljwcodePageTitleViewAlignment) {
    ljwcodePageTitleViewAlignmentLeft = 0,
    ljwcodePageTitleViewAlignmentCenter = 1,
    ljwcodePageTitleViewAlignmentRight = 2
};

typedef NS_ENUM(NSInteger,ljwcodePageTextVerticalAlignment) {
    ljwcodePageTextVerticalAlignmentTop = 0,
    ljwcodePageTextVerticalAlignmentCenter = 1,
    ljwcodePageTextVerticalAlignmentBottom = 2
};

typedef NS_ENUM(NSInteger,ljwcodeShadowLineCap) {
    ljwcodeShadowLineCapRound = 0,
    ljwcodeShadowLineCapSquare = 1
};

typedef NS_ENUM(NSInteger,ljwcodeShadowLineAnimationType) {
    ljwcodeShadowLineAnimationTypePan = 0,
    ljwcodeShadowLineAnimationTypeZoom = 1,
    ljwcodeShadowLineAnimationTypeNone = 2
};

typedef NS_ENUM(NSInteger,ljwcodeShadowLIneAniamationAlignment) {
    ljwcodeShadowLIneAniamationAlignmentBottom  = 0,
    ljwcodeShadowLIneAniamationAlignmentCenter = 1,
    ljwcodeShadowLIneAniamationAlignmentTop = 2
};

@interface ljwcodePageViewControllerConfig : NSObject

+(ljwcodePageViewControllerConfig *)defaultConfig;

@property(nonatomic,strong)UIColor *titleNormalColor;

@property(nonatomic,strong)UIColor *titleSelectedColor;

@property(nonatomic,strong)UIFont *titleNormalFont;

@property(nonatomic,strong)UIFont *titleSelectedFont;

@property(nonatomic,assign)CGFloat titleSpace;

@property(nonatomic,assign)CGFloat titleWidth;

@property(nonatomic,assign)BOOL titleColorTransition;

@property(nonatomic,assign)ljwcodeTitleViewStyle titleViewStyle;

@property(nonatomic,assign)ljwcodePageTitleViewAlignment titleViewAlignment;

@property(nonatomic,assign)ljwcodePageTextVerticalAlignment textVerticalAlignment;

@property(nonatomic,assign)ljwcodeShadowLineCap shadowLineCap;

@property(nonatomic,assign)ljwcodeShadowLineAnimationType shadowLineAnimationType;

@property(nonatomic,assign)ljwcodeShadowLIneAniamationAlignment shadowLineAlignment;

@property(nonatomic,assign)CGFloat titleViewHeight;

@property(nonatomic,strong)UIColor *titleViewBackgroundColor;

@property(nonatomic,assign)UIEdgeInsets titleViewInsets;

@property(nonatomic,assign)BOOL showTitleViewInNavigationBar;

@property(nonatomic,assign)BOOL showBottomShoadowLine;

@property(nonatomic,assign)CGFloat shadowLineHeight;

@property(nonatomic,assign)CGFloat shadowLineWidth;

@property(nonatomic,strong)UIColor *shadowLineCOlor;

@property(nonatomic,assign)BOOL showShadowLineHidden;

@property(nonatomic,assign)CGFloat separatorLineHeight;

@property(nonatomic,strong)UIColor *separatorLineColor;

@property(nonatomic,assign)BOOL showSeparatorLine;

@property(nonatomic,strong)UIColor *segmentedTintColor;


@end

@interface ljwcodePageViewConfig : NSObject

+(ljwcodePageViewConfig *)defalultConfig;

@property(nonatomic,strong)UIColor *titleNormalColor;

@property(nonatomic,strong)UIColor *titleSelectedColor;

@property(nonatomic,strong)UIFont *titleNormalFont;

@property(nonatomic,strong)UIFont *titleSelectedFont;

@property(nonatomic,assign)CGFloat titleSpace;

@property(nonatomic,assign)CGFloat titleWidth;

@property(nonatomic,assign)BOOL titleColorTransition;

@property(nonatomic,assign)CGFloat titleViewHeight;

@property(nonatomic,strong)UIColor *titleViewBackgroundColor;

@property(nonatomic,assign)UIEdgeInsets titleViewInsets;

@property(nonatomic,assign)BOOL showTitleViewInNavigationBar;

@property(nonatomic,assign)BOOL showBottomShoadowLine;

@property(nonatomic,assign)CGFloat shadowLineHeight;

@property(nonatomic,assign)CGFloat shadowLineWidth;

@property(nonatomic,strong)UIColor *shadowLineCOlor;

@property(nonatomic,assign)BOOL showShadowLineHidden;

@property(nonatomic,assign)CGFloat separatorLineHeight;

@property(nonatomic,strong)UIColor *separatorLineColor;

@property(nonatomic,assign)BOOL showSeparatorLine;

@property(nonatomic,strong)UIColor *segmentedTintColor;


@property(nonatomic,assign)ljwcodeTitleViewStyle titleViewStyle;

@property(nonatomic,assign)ljwcodePageTitleViewAlignment titleViewAlignment;

@property(nonatomic,assign)ljwcodePageTextVerticalAlignment textVerticalAlignment;

@property(nonatomic,assign)ljwcodeShadowLineCap shadowLineCap;

@property(nonatomic,assign)ljwcodeShadowLineAnimationType shadowLineAnimationType;

@property(nonatomic,assign)ljwcodeShadowLIneAniamationAlignment shadowLineAlignment;

@end

NS_ASSUME_NONNULL_END
