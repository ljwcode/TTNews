//
//  TTNavigationBar.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface TTNavigationBar : UISearchBar

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textFieldLeftView:(UIImageView *)leftView tintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
