//
//  UITabBar+LLTabBarItem.h
//  LLRiseTabBarDemo
//
//  Created by 1 on 2020/6/18.
//  Copyright © 2020 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (LLTabBarItem)

-(void)showBadgeWithItemIndex:(NSInteger)index bageNumber:(NSInteger)number;

-(void)hideBadgeWithItemIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
