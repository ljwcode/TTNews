//
//  ljwcodeNavigationViewController.h
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ljwcodeNavigationViewController : UINavigationController

@property(nonatomic,assign)UIStatusBarStyle statusBarStyle;

@property(nonatomic,strong)UIColor *barBackgroundColor;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,strong)UIColor *barTintColor;

@end

NS_ASSUME_NONNULL_END
