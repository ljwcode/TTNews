//
//  UINavigationBar+ThemeChange.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UINavigationBar+ThemeChange.h"
#import "UIView+ThemeChange.h"
#import "TTMethodSWizzle.h"
#import "TTThemeManager.h"

@interface UINavigationBar()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UINavigationBar (ThemeChange)

+ (void)load {
    [self swizzleNavColor];
}

+ (void)swizzleNavColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBarTintColor:) swappedMethod:@selector(TT_setBarTintColor:)];
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTintColor:) swappedMethod:@selector(TT_setNavTintColor:)];
    });
}

- (void)TT_setBarTintColor:(UIColor *)color {
    UIColor *barTintColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setBarTintColor:"];
    if (barTintColor) {
        [self TT_setBarTintColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBarTintColor:"];
    } else {
        [self TT_setBarTintColor:color];
    }
}

- (void)TT_setNavTintColor:(UIColor *)color {
    UIColor *tintColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setNavTintColor:"];
    if (tintColor) {
        [self TT_setNavTintColor:tintColor];
        [self.pickers setObject:tintColor forKey:@"setTintColor:"];
    } else {
        [self TT_setNavTintColor:color];
    }
}

@end
