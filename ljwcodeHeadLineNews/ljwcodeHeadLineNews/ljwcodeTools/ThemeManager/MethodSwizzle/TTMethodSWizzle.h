//
//  TTMethodSWizzle.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTMethodSWizzle : NSObject

+ (void)swizzleInstanceMethodWithClass:(Class)originClass
                          OriginMethod:(SEL)originMethod
                         swappedMethod:(SEL)swappedMethod;

+ (void)swizzleClassMethodWithClass:(Class)originClass
                       OriginMethod:(SEL)originMethod
                      swappedMethod:(SEL)swappedMethod;

@end

NS_ASSUME_NONNULL_END
