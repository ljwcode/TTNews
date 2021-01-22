//
//  TTFontSizeChangeModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/21.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTFontSizeChangeModel : NSObject

@property(nonatomic,copy)NSString *tip;

@property(nonatomic,assign)float fontSize;

@property(nonatomic,assign)float tabBarViewHeight;

@property(nonatomic,assign)float iPhoneXTabBarViewHeight;

@end

NS_ASSUME_NONNULL_END
