//
//  ButtonViewTools.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ButtonViewTools : NSObject

-(UIImageView *)packageImgView:(UIImage *)image imgViewFrame:(CGRect)frame paraentView:(UIView *)View;

-(UILabel *)packageLabel:(NSString *)title paraentView:(UIView *)View labelFrame:(CGRect)frame textColor:(UIColor * _Nullable)textColor fontSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
