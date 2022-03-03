//
//  TTTabBar.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/19.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTTabBarItem;

@interface TTTabBar : UITabBar

@property(nonatomic,strong)NSMutableArray<TTTabBarItem *> *tabBarItemArray;

-(void)setCurrentIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
