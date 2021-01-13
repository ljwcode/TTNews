//
//  UIView+Frame.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/21.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint  center=self.center;
    center.x=centerX;
    self.center=center;

}
-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}
-(CGFloat)centerY{
    return self.center.y;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)x{
    return self.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)y{
    return self.origin.y;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize)size{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

-(UIWindow *)getCurrentWindow{
    if([[[UIApplication sharedApplication]delegate]window]){
        return [[[UIApplication sharedApplication]delegate]window];
    }else{
        if(@available(iOS 13.0,*)){
            NSArray *array = [[[UIApplication sharedApplication]connectedScenes]allObjects];
            UIWindowScene *windowScene = (UIWindowScene *)array[0];
            UIWindow *mainWindow = [windowScene valueForKey:@"delegate.window"];
            if(mainWindow){
                return  mainWindow;
            }else{
                return [UIApplication sharedApplication].windows.lastObject;
            }
        }else{
            return [UIApplication sharedApplication].keyWindow;
        }
    }
}

@end

