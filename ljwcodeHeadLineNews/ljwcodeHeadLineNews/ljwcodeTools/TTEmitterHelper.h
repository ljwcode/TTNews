//
//  TTEmitterHelper.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTEmitterHelper : NSObject

@property(nonatomic,weak)UIView *longPressGreView;

+(TTEmitterHelper *)shareInstance;

+(NSArray<UIImage *>*)defaultImage;

-(void)showEmitterCellWithImage:(NSArray<UIImage *>*)image isShock:(BOOL)shock onView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
