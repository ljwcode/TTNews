//
//  TTNavigationBar.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TT_NavigationBarDelegate <NSObject>

-(void)TT_PushToSearchVC;

@end

@interface TTNavigationBar : UISearchBar

@property (nonatomic, strong) UIImageView *leftView;

@property(nonatomic,weak)id<TT_NavigationBarDelegate>TT_NaviDelegate;

@end

NS_ASSUME_NONNULL_END
