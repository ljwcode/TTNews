//
//  ljwcodePageViewControllerUtil.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/14.
//

#import "ljwcodePageViewControllerUtil.h"

@interface ljwcodePageViewControllerUtil()

@end

@implementation ljwcodePageViewControllerUtil

+(CGFloat)textForWidth:(NSString *)text textFont:(UIFont *)Font size:(CGSize)size{
    NSStringDrawingOptions option = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
        NSFontAttributeName : Font,
        NSParagraphStyleAttributeName:paragraphStyle
    };
    
    CGSize textSize = [text boundingRectWithSize:size options:option attributes:attributes context:nil].size;
    return textSize.width;
}

+(UIColor *)colorTransform:(UIColor *)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress {
    if(!fromColor || !toColor){
        return  [UIColor blackColor];
    }
    
    progress = progress >= 1 ? 1 : progress;
    progress = progress <= 0 ? 0 : progress;
    
    const CGFloat *fromComponents = CGColorGetComponents(fromColor.CGColor);
    const CGFloat *toComponents = CGColorGetComponents(toColor.CGColor);
    
    size_t fromColorNumber = CGColorGetNumberOfComponents(fromColor.CGColor);
    size_t toColorNumber = CGColorGetNumberOfComponents(toColor.CGColor);
    
    if(fromColorNumber == 2){
        CGFloat white = fromComponents[0];
        fromColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        fromComponents = CGColorGetComponents(fromColor.CGColor);
    }
    
    if(toColorNumber == 2) {
        CGFloat white = toComponents[0];
        toColor = [UIColor colorWithRed:white green:white blue:white alpha:1];
        toComponents = CGColorGetComponents(toColor.CGColor);
    }
    
    CGFloat red = fromComponents[0] * (1 - progress) - toComponents[0] * progress;
    CGFloat green = fromComponents[1] * (1 - progress) - toComponents[1] * progress;
    CGFloat blue = fromComponents[2] * (1 - progress) - toComponents[2] * progress;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+(void)showAnimationShadow:(UIView *)shadow shadowWidth:(CGFloat)shadowWidth fromItemRect:(CGRect)fromItemRect toItemRect:(CGRect)toItemRect shadowAnimationType:(ljwcodeShadowLineAnimationType)type progress:(CGFloat)progress{
    if(type == ljwcodeShadowLineAnimationTypeNone){
        return;
    }
    
    if(type == ljwcodeShadowLineAnimationTypePan){
        CGFloat distance = CGRectGetMidX(toItemRect) - CGRectGetMidX(fromItemRect);
        CGFloat centerX = CGRectGetMidX(fromItemRect) + fabs(progress) * distance;
        shadow.center = CGPointMake(centerX, shadow.center.y);
    }
    
    if(type == ljwcodeShadowLineAnimationTypeZoom) {
        CGFloat distance = CGRectGetMidX(toItemRect) - CGRectGetMidX(fromItemRect);
        CGFloat fromX = CGRectGetMidX(fromItemRect) - shadowWidth / 2.0;
        CGFloat toX = CGRectGetMidX(toItemRect) - shadowWidth / 2.0;
        if(progress > 0) {
            if (progress <= 0.5) {
                //让过程变成0~1
                CGFloat newProgress = 2*fabs(progress);
                CGFloat newWidth = shadowWidth + newProgress*distance;
                CGRect shadowFrame = shadow.frame;
                shadowFrame.size.width = newWidth;
                shadowFrame.origin.x = fromX;
                shadow.frame = shadowFrame;
            }else if (progress >= 0.5) { //后半段0.5~1，x变大 w变小
                //让过程变成1~0
                CGFloat newProgress = 2*(1-fabs(progress));
                CGFloat newWidth = shadowWidth + newProgress*distance;
                CGFloat newX = toX - newProgress*distance;
                CGRect shadowFrame = shadow.frame;
                shadowFrame.size.width = newWidth;
                shadowFrame.origin.x = newX;
                shadow.frame = shadowFrame;
            }
        }else{//向左移动
            //前半段0~-0.5，x变小 w变大
            if (progress >= -0.5) {
                //让过程变成0~1
                CGFloat newProgress = 2*fabs(progress);
                CGFloat newWidth = shadowWidth + newProgress*distance;
                CGFloat newX = fromX - newProgress*distance;
                CGRect shadowFrame = shadow.frame;
                shadowFrame.size.width = newWidth;
                shadowFrame.origin.x = newX;
                shadow.frame = shadowFrame;
            }else if (progress <= -0.5) { //后半段-0.5~-1，x变大 w变小
                //让过程变成1~0
                CGFloat newProgress = 2*(1-fabs(progress));
                CGFloat newWidth = shadowWidth + newProgress*distance;
                CGRect shadowFrame = shadow.frame;
                shadowFrame.size.width = newWidth;
                shadowFrame.origin.x = toX;
                shadow.frame = shadowFrame;
            }
        }
    }
}

@end

#import <objc/runtime.h>

static const NSString *priorityScrollKey = @"priorityScrollKey";

@implementation UIView (PriorityScroll)

-(void)setPriorityScrollAtFirst:(BOOL)priorityScrollAtFirst {
    objc_setAssociatedObject(self, &priorityScrollKey, @(priorityScrollAtFirst), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)priorityScrollAtFirst{
    return [objc_getAssociatedObject(self, &priorityScrollKey) boolValue];
}

@end

static const NSString *viewControllerTitleKey = @"viewControllerTitleKey";

@implementation UIViewController (viewControllerTitle)

-(void)setVc_title:(NSString *)vc_title {
    objc_setAssociatedObject(self, &viewControllerTitleKey, vc_title, OBJC_ASSOCIATION_COPY);
}

-(NSString *)vc_title {
    return objc_getAssociatedObject(self, &viewControllerTitleKey);
}

@end

static const NSString *otherGestureRecBlockKey = @"otherGestureRecBlockKey";

@implementation UIScrollView (GestureRec)

+(void)load {
    [self addGestureRecognizerObserver];
}

+(void)addGestureRecognizerObserver {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originSelector = @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
        SEL swizzleSelector = @selector(swizzle_gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
        
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
        
        BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        if(didAddMethod) {
            class_replaceMethod(class, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else{
            method_exchangeImplementations(originMethod, swizzleMethod);
        }
    });
}

-(BOOL)swizzle_gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL gestureRec = self.gestureRecBlock ? self.gestureRecBlock(otherGestureRecognizer) : NO;
    return gestureRec;
}

-(void)setGestureRecBlock:(otherGestureRecognizeBlock)gestureRecBlock {
    objc_setAssociatedObject(self, &otherGestureRecBlockKey, gestureRecBlock, OBJC_ASSOCIATION_COPY);
}

-(otherGestureRecognizeBlock)gestureRecBlock {
    return  objc_getAssociatedObject(self, &otherGestureRecBlockKey);
}

@end
