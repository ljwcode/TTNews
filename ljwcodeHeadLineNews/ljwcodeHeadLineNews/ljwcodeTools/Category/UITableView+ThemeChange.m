//
//  UITableView+ThemeChange.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UITableView+ThemeChange.h"
#import "UIView+ThemeChange.h"
#import "TTMethodSWizzle.h"
#import "TTThemeManager.h"

@interface UITableView()

@property (nonatomic, strong) NSMutableDictionary <NSString *, UIColor *> *pickers;

@end

@implementation UITableView (ThemeChange)

+ (void)load {
    [self swizzleTableViewColor];
}

+ (void)swizzleTableViewColor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [TTMethodSWizzle swizzleInstanceMethodWithClass:[self class] OriginMethod:@selector(setBackgroundColor:) swappedMethod:@selector(TT_setTableViewBackgroundColor:)];
    });
}

- (void)TT_setTableViewBackgroundColor:(UIColor *)color {
    UIColor *barTintColor = [[TTThemeManager shareManager] colorWithReceiver:self withTag:self.tag selString:@"setTableViewBackgroundColor:"];
    if (barTintColor) {
        [self TT_setTableViewBackgroundColor:barTintColor];
        [self.pickers setObject:barTintColor forKey:@"setBackgroundColor:"];
    } else {
        [self TT_setTableViewBackgroundColor:color];
    }
}

@end
