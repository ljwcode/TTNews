//
//  ljwcodeEmitterHelper.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/20.
//  Copyright © 2020 melody. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ljwcodeEmitterHelper : NSObject

@property(nonatomic,weak)UIView *longPressGreView;

+(ljwcodeEmitterHelper *)shareInstance;

+(NSArray<UIImage *>*)defaultImage;

-(void)showEmitterCellWithImage:(NSArray<UIImage *>*)image isShock:(BOOL)shock onView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
