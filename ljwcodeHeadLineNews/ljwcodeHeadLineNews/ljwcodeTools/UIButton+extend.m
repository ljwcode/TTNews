//
//  UIButton+extend.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UIButton+extend.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@implementation UIButton (extend)

+(UIButton *(^)(UIButtonType buttontype))buttonType{
    return ^UIButton *(UIButtonType buttonType){
        return [UIButton buttonWithType:buttonType];
    };
}

-(UIButton *(^)(NSString *title,UIControlState state))buttonTitle{
    return ^UIButton* (NSString *title,UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

-(UIButton *(^)(UIColor *titleColor,UIControlState state))titleColor{
    return ^UIButton *(UIColor *titleColor,UIControlState state){
        [self setTitleColor:titleColor forState:state];
        return self;
    };
}

-(UIButton *(^)(UIImage *bgImage,UIControlState state))bgImage{
    return ^UIButton *(UIImage *bgImage,UIControlState state){
        [self setBackgroundImage:bgImage forState:state];
        return self;
    };
}

-(UIButton *(^)(UIImage *showImage,UIControlState state))showImage{
    return ^UIButton *(UIImage *showImage,UIControlState state){
        [self setImage:showImage forState:state];
        return self;
    };
}

-(UIButton *(^)(UIColor *borderColor,CGFloat borderWidth))buttonLayer{
    return ^UIButton *(UIColor *borderColor,CGFloat borderWidth){
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

@end
