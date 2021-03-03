//
//  TTScreen.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTScreen.h"
#import <UIKit/UIKit.h>

@implementation TTScreen

//iphone xs max
+ (CGSize)sizeFor65Inch{
    return CGSizeMake(414,896);
}

//iphone xr
+ (CGSize)sizeFor61Inch{
    return CGSizeMake(414,896);
}

// iphonex
+ (CGSize)sizeFor58Inch{
    return CGSizeMake(375,812);
}
//plus
//4 /5

+ (BOOL)TT_isPhoneX{
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
}

+ (CGFloat)getStatusBarHight {
   float statusBarHeight = 0;
   if (@available(iOS 13.0, *)) {
       UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
       statusBarHeight = statusBarManager.statusBarFrame.size.height;
   }
   else {
       statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
   }
   return statusBarHeight;
}

@end
