//
//  UIView+Frame.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/21.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;

@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;

@property(nonatomic,assign)CGSize size;

@property(nonatomic,assign)CGPoint origin;

-(UIViewController *)getCurrentViewController;

-(UIWindow *)getCurrentWindow;

@end

NS_ASSUME_NONNULL_END
