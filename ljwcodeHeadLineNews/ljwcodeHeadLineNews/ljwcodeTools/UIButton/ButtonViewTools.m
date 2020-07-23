//
//  ButtonViewTools.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ButtonViewTools.h"
#import <UIView+Frame.h>

@implementation ButtonViewTools

-(UIImageView *)packageImgView:(UIImage *)image imgViewFrame:(CGRect)frame paraentView:(UIView *)View
{
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    imgView.image = image;
    [View addSubview:imgView];
    
    return imgView;
}

-(UILabel *)packageLabel:(NSString *)title paraentView:(UIView *)View labelFrame:(CGRect)frame textColor:(UIColor * _Nullable)textColor fontSize:(CGFloat)fontSize
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    label.textColor = textColor;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.font = [UIFont systemFontOfSize:fontSize];
    [View addSubview:label];
    
    return label;
}

@end
