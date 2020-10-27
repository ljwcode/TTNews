//
//  UILabel+ThemeChange.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UILabel+ThemeChange.h"
#import "UIView+ThemeChange.h"
#import "TTMethodSWizzle.h"
#import "TTThemeManager.h"

@interface UILabel()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UILabel (ThemeChange)

+ (void)load {
    [self swizzleLabelTextColor];
}

+ (void)swizzleLabelTextColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setTextColor:) swappedMethod:@selector(TT_setTextColor:)];
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setHighlightedTextColor:) swappedMethod:@selector(TT_setHighlightedTextColor:)];
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setShadowColor:) swappedMethod:@selector(TT_setShadowColor:)];
    });
}

- (void)TT_setTextColor:(UIColor *)color {
    UIColor *textColor = [[TTThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:[NSString stringWithFormat:@"%ld:textColor", self.tag]];
    if (textColor) {
        [self TT_setTextColor:textColor];
        [self.pickers setObject:textColor forKey:@"setTextColor:"];
    } else {
        [self TT_setTextColor:color];
    }
}

- (void)TT_setHighlightedTextColor:(UIColor *)color {
    UIColor *highlightColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setHighlightedTextColor:"];
    if (highlightColor) {
        [self TT_setHighlightedTextColor:highlightColor];
        [self.pickers setObject:highlightColor forKey:@"setHighlightedTextColor:"];
    } else {
        [self TT_setHighlightedTextColor:color];
    }
}

- (void)TT_setShadowColor:(UIColor *)color {
    UIColor *shadowColor = [[TTThemeManager shareManager] colorWithReceiver:self selString:@"setShadowColor:"];
    if (shadowColor) {
        [self TT_setShadowColor:shadowColor];
        [self.pickers setObject:shadowColor forKey:@"setShadowColor:"];
    } else {
        [self TT_setShadowColor:color];
    }
}

@end
