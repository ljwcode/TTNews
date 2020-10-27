//
//  UITableViewCell+ThemeChange.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UITableViewCell+ThemeChange.h"
#import "UIView+ThemeChange.h"
#import "TTMethodSWizzle.h"
#import "TTThemeManager.h"

@interface UITableViewCell()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UITableViewCell (ThemeChange)

+ (void)load {
    [self swizzleTableViewCellColor];
}

+ (void)swizzleTableViewCellColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBackgroundColor:) swappedMethod:@selector(TT_setTableViewCellBackgroundColor:)];
    });
}

- (void)TT_setTableViewCellBackgroundColor:(UIColor *)color {
    UIColor *barTintColor = [[TTThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:[NSString stringWithFormat:@"%ld:tableViewCellBackgroundColor", (long)self.tag]];
    if (barTintColor) {
        [self TT_setTableViewCellBackgroundColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBackgroundColor:"];
    } else {
        [self TT_setTableViewCellBackgroundColor:color];
    }
}

@end
