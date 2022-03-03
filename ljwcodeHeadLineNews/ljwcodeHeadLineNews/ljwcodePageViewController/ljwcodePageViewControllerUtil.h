//
//  ljwcodePageViewControllerUtil.h
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/14.
//

#import <Foundation/Foundation.h>
#import "ljwcodePageViewControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ljwcodePageViewControllerUtil : NSObject

+(CGFloat)textForWidth:(NSString *)text textFont:(UIFont *)Font size:(CGSize)size;

+(UIColor *)colorTransform:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress;

+(void)showAnimationShadow:(UIView *)shadow shadowWidth:(CGFloat)shadowWidth fromItemRect:(CGRect)fromItemRect toItemRect:(CGRect)toItemRect shadowAnimationType:(ljwcodeShadowLineAnimationType)type progress:(CGFloat)progress;

@end

@interface UIView (PriorityScroll)

@property(nonatomic,assign)BOOL priorityScrollAtFirst;

@end

@interface UIViewController (controllerTitle)

@property(nonatomic,copy)NSString *vc_title;

@end

typedef BOOL(^otherGestureRecognizeBlock)(UIGestureRecognizer *gestureRec);

@interface UIScrollView (GestureRec)<UIGestureRecognizerDelegate>

@property(nonatomic,copy)otherGestureRecognizeBlock gestureRecBlock;

@end

NS_ASSUME_NONNULL_END
