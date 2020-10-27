//
//  UIColor+TTColorTools.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TTColorTools)

+ (UIColor *)colorWithHexString:(NSString *)string;

+ (UIColor *)colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
