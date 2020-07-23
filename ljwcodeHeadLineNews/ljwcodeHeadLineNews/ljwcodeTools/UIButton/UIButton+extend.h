//
//  UIButton+extend.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (extend)

+(UIButton *(^)(UIButtonType buttontype))buttonType;

-(UIButton *(^)(NSString *title,UIControlState state))buttonTitle;

-(UIButton *(^)(UIColor *titleColor,UIControlState state))titleColor;

-(UIButton *(^)(UIImage *bgImage,UIControlState state))bgImage;

-(UIButton *(^)(UIImage *showImage,UIControlState state))showImage;

-(UIButton *(^)(UIColor *borderColor,CGFloat borderWidth))buttonLayer;



@end

NS_ASSUME_NONNULL_END
