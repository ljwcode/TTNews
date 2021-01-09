//
//  TT_CustomerTabBar.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/9.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TT_CustomerTabBar;

@protocol TT_CustomerTabBarDelegate <NSObject>

-(void)tabBar:(TT_CustomerTabBar *)tabBar WithTabBarSelectedIndex:(NSInteger)index;

@end

@interface TT_CustomerTabBar : UIView

@property(nonatomic,weak)id<TT_CustomerTabBarDelegate>delegate;

@property(nonatomic,strong)NSArray *itemArray;

@property(nonatomic,strong)UITabBarController *tabBarController;

@property(nonatomic,copy)void(^selectedIndexBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
