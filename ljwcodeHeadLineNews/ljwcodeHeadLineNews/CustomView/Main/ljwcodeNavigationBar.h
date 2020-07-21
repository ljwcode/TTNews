//
//  ljwcodeNavigationBar.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger
{
    ljwcodeNavigationBarActionSend = 0,
    ljwcodeNavigationBarActonMind  = 1,
}ljwcodeNavigationBarAction;

@interface ljwcodeNavigationBar : UISearchBar

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textFieldLeftView:(UIImageView *)leftView showCancelButton:(BOOL)showCancelButton tintColor:(UIColor *)tintColor;

/// 让searchBar的内容居左显示
- (void)setLeftPlaceholder;

@end

NS_ASSUME_NONNULL_END
