//
//  ljwcodePageViewControllerConfig.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/14.
//

#import "ljwcodePageViewControllerConfig.h"

@implementation ljwcodePageViewControllerConfig

+(ljwcodePageViewControllerConfig *)defaultConfig{
    ljwcodePageViewControllerConfig *config = [[ljwcodePageViewControllerConfig alloc]init];
    
    config.titleNormalFont = [UIFont systemFontOfSize:18];
    config.titleSelectedFont = [UIFont systemFontOfSize:18];
    config.titleNormalColor = [UIColor blackColor];
    config.titleSelectedColor = [UIColor redColor];
    config.titleSpace = 15.0;
    config.titleColorTransition = true;
    
    config.titleViewHeight = 40.0;
    config.titleViewInsets = UIEdgeInsetsMake(10, 10, 0, 10);
    config.titleViewAlignment = ljwcodePageTitleViewAlignmentLeft;
    config.titleViewBackgroundColor = [UIColor clearColor];
    
    config.shadowLineHeight = 3.0;
    config.shadowLineWidth = 20.0;
    config.shadowLineCOlor = [UIColor redColor];
    config.showShadowLineHidden = false;
    config.shadowLineAnimationType = ljwcodeShadowLineAnimationTypePan;
    config.shadowLineAlignment = ljwcodeShadowLIneAniamationAlignmentBottom;
    
    config.separatorLineColor = [UIColor lightGrayColor];
    config.separatorLineHeight = 0.5;
    config.showSeparatorLine = false;
    
    config.segmentedTintColor = [UIColor  blackColor];
    
    return config;
}

@end

@implementation ljwcodePageViewConfig

+(ljwcodePageViewConfig *)defalultConfig {
    ljwcodePageViewConfig *config = [[ljwcodePageViewConfig alloc]init];
    
    config.titleNormalFont = [UIFont systemFontOfSize:18];
    config.titleSelectedFont = [UIFont systemFontOfSize:18];
    config.titleNormalColor = [UIColor grayColor];
    config.titleSelectedColor = [UIColor blackColor];
    config.titleSpace = 10.0;
    config.titleColorTransition = true;
    
    config.titleViewHeight = 40.0;
    config.titleViewInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    config.titleViewAlignment = ljwcodePageTitleViewAlignmentLeft;
    config.titleViewBackgroundColor = [UIColor clearColor];
    
    config.shadowLineHeight = 3.0;
    config.shadowLineWidth = 30.0;
    config.shadowLineCOlor = [UIColor blackColor];
    config.showShadowLineHidden = false;
    config.shadowLineAnimationType = ljwcodeShadowLineAnimationTypePan;
    config.shadowLineAlignment = ljwcodeShadowLIneAniamationAlignmentBottom;
    
    config.separatorLineColor = [UIColor lightGrayColor];
    config.separatorLineHeight = 0.5;
    config.showSeparatorLine = false;
    
    config.segmentedTintColor = [UIColor  blackColor];
    
    return config;
}

@end
