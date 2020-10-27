//
//  TTThemeManager.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTThemeManager.h"
#import "UIColor+TTColorTools.h"

NSString * const TTThemeChangeNotification;
NSString * const TTThemeChangeKey;

@interface TTThemeManager()

@property (nonatomic, strong) NSDictionary *colorInfoDic;

@property (nonatomic, strong) NSDictionary *specialColorInfoDic;

@end

@implementation TTThemeManager

+ (instancetype)shareManager {
    static TTThemeManager *instance;
    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[TTThemeManager alloc] init];
//        TTThemeChangeType type = [[[NSUserDefaults standardUserDefaults] valueForKey:TTThemeChangeKey] integerValue];
//        type = type ?: TTThemeChangeTypeDefault;
//        instance.themeType = type;
//    });
    return instance;
}

- (void)setThemeType:(TTThemeChangeType)themeType {
    _themeType = themeType;
    
    NSString *path = nil;
    NSString *tagPath = nil;
    switch (themeType) {
        case TTThemeChangeTypeDefault:{
                path = [[NSBundle mainBundle] pathForResource:@"TTThemeDefault" ofType:@"plist"];
                tagPath = [[NSBundle mainBundle] pathForResource:@"TTThemeDefaultTag" ofType:@"plist"];
            }
            break;
        case TTThemeChangeTypeNight:{
                path = [[NSBundle mainBundle] pathForResource:@"TTThemeNight" ofType:@"plist"];
                tagPath = [[NSBundle mainBundle] pathForResource:@"TTThemeNightTag" ofType:@"plist"];
            }
            break;
    }
    _colorInfoDic = [NSDictionary dictionaryWithContentsOfFile:path];
    _specialColorInfoDic = [NSDictionary dictionaryWithContentsOfFile:tagPath];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TTThemeChangeNotification object:nil];
}

- (UIColor *)colorWithReceiver:(id)receiver selString:(NSString *)selector {
    UIColor *color = [UIColor colorWithHexString:[_colorInfoDic objectForKey:selector]];
    return color;
}

- (UIColor *)colorWithReceiver:(id)receiver withTag:(NSInteger)tag selString:(NSString *)selector {
    UIColor *color = nil;
    if ([_specialColorInfoDic objectForKey:selector]) {
        color = [UIColor colorWithHexString:[_specialColorInfoDic objectForKey:selector]];
    }
    return color;
}

@end
