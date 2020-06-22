//
//  LLNavigationController.h
//  LLRiseTabBarDemo
//
//  Created by 1 on 2020/6/18.
//  Copyright © 2020 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ljwcodeNavigationController : UINavigationController

@property(nonatomic,strong)UIImage *defaultImage;

-(void)startGestureRecnozier;

-(void)stopGestureRecnozier;

@end

NS_ASSUME_NONNULL_END
