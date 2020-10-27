//
//  TTThemeManager.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,TTThemeChangeType){
    TTThemeChangeTypeDefault = 0,
    TTThemeChangeTypeNight   = 1
};

extern NSString * const TTThemeChangeNotification;
extern NSString * const TTThemeChangeKey;

@interface TTThemeManager : NSObject

@property (nonatomic, assign) TTThemeChangeType themeType;


+ (instancetype)shareManager;

- (UIColor *)colorWithReceiver:(id)receiver selString:(NSString *)selector;

- (UIColor *)colorWithReceiver:(id)receiver withTag:(NSInteger)tag selString:(NSString *)selector;

@end

NS_ASSUME_NONNULL_END
