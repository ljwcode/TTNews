//
//  TTScreen.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

#define SCREEN_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.height : [[UIScreen mainScreen ] bounds].size.width)
#define SCREEN_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.width : [[UIScreen mainScreen ] bounds].size.height)

#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)

#define IS_IPHONE_X (SCREEN_WIDTH == [TTScreemScreen sizeFor58Inch].width && SCREEN_HEIGHT == [TTScreemScreen sizeFor58Inch].height)
#define IS_IPHONE_XR (SCREEN_WIDTH == [TTScreemScreen sizeFor61Inch].width && SCREEN_HEIGHT == [TTScreemScreen sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IS_IPHONE_XMAX (SCREEN_WIDTH == [TTScreemScreen sizeFor65Inch].width && SCREEN_HEIGHT == [TTScreemScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define STATUSBARHEIGHT (IS_IPHONE_X_XR_MAX ? 44 : 20)

#define UI(x) UIAdapter(x)
#define UIRect(x,y,width,height) UIRectAdapter(x,y,width,height)

static inline NSInteger UIAdapter (float x){
    //1 - 分机型 特定的比例
    
    //2 - 屏幕宽度按比例适配
    CGFloat scale = 414 / SCREEN_WIDTH;
    return (NSInteger)x /scale;
}

static inline CGRect UIRectAdapter(x,y,width,height){
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

@interface TTScreen : NSObject

//iphone xs max
+ (CGSize)sizeFor65Inch;

//iphone xr
+ (CGSize)sizeFor61Inch;

// iphonex
+ (CGSize)sizeFor58Inch;

+ (BOOL)TT_isPhoneX;

+ (CGFloat)getStatusBarHight;

@end

NS_ASSUME_NONNULL_END
