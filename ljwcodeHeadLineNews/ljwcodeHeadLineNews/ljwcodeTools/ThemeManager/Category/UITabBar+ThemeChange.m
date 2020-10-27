//
//  UITabBar+ThemeChange.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UITabBar+ThemeChange.h"
#import "TTMethodSWizzle.h"
#import "UIView+ThemeChange.h"
#import "TTThemeManager.h"

@interface UITabBar()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UITabBar (ThemeChange)

+ (void)load {
    [self swizzleTabColor];
}

+ (void)swizzleTabColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBarTintColor:) swappedMethod:@selector(ly_setTabBarTintColor:)];
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setUnselectedItemTintColor:) swappedMethod:@selector(ly_setUnselectedItemTintColor:)];
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTintColor:) swappedMethod:@selector(ly_setTabbarBackgroundTintColor:)];
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTextColor:) swappedMethod:@selector(ly_setTabbarTextColor:)];
    });
}

- (void)ly_setTabBarTintColor:(UIColor *)color {
    UIColor *barTintColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setTabBarTintColor:"];
    if (barTintColor) {
        [self ly_setTabBarTintColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBarTintColor:"];
    } else {
        [self ly_setTabBarTintColor:color];
    }
}

- (void)ly_setUnselectedItemTintColor:(UIColor *)color {
    UIColor *unselectedColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setUnselectedItemTintColor:"];
    if (unselectedColor) {
        [self.pickers setObject:unselectedColor forKey:@"setUnselectedItemTintColor:"];
        [self ly_setUnselectedItemTintColor:unselectedColor];
    } else {
        [self ly_setUnselectedItemTintColor:color];
    }
}

- (void)ly_setTabbarBackgroundTintColor:(UIColor *)color {
    UIColor *bgTintColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setTabbarBackgroundTintColor:"];
    if (bgTintColor) {
        [self.pickers setObject:bgTintColor forKey:@"setTintColor:"];
    } else {
        [self ly_setTabbarBackgroundTintColor:color];
    }
}

- (void)ly_setTabbarTextColor:(UIColor *)color {
    UIColor *textColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setTabbarTextColor:"];
    if (textColor) {
        [self.pickers setObject:textColor forKey:@"setTextColor:"];
        [self ly_setUnselectedItemTintColor:textColor];
    } else {
        [self ly_setUnselectedItemTintColor:color];
    }
}

@end
