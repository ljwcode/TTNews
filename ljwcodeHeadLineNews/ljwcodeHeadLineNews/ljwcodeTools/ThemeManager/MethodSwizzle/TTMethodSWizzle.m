//
//  TTMethodSWizzle.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTMethodSWizzle.h"

@implementation TTMethodSWizzle

+ (void)swizzleInstanceMethodWithClass:(Class)originClass
                          OriginMethod:(SEL)originMethod
                         swappedMethod:(SEL)swappedMethod {
    
    SEL originalSelector = originMethod;
    SEL swappedSelector = swappedMethod;
    
    Method originalMethod = class_getInstanceMethod(originClass, originalSelector);
    Method newMethod = class_getInstanceMethod(originClass, swappedSelector);
    
    BOOL didAddMethod = class_addMethod(originClass, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(originClass, swappedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

+ (void)swizzleClassMethodWithClass:(Class)originClass
                       OriginMethod:(SEL)originMethod
                      swappedMethod:(SEL)swappedMethod {
    SEL originalSelector = originMethod;
    SEL swappedSelector = swappedMethod;
    
    Method originalMethod = class_getClassMethod(originClass, originalSelector);
    Method newMethod = class_getClassMethod(originClass, swappedSelector);
    
    BOOL didAddMethod = class_addMethod(originClass, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (didAddMethod) {
        class_replaceMethod(originClass, swappedSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}


@end
