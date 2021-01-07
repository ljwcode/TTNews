//
//  UIViewController+TT_familyFontSizeConfigura.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/7.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "UIViewController+TT_familyFontSizeConfigura.h"
#import <objc/runtime.h>

CG_INLINE CGFloat
TT_FontSizeScale(CGFloat floatValue,CGFloat scale){
    scale = scale == 0 ? TT_ScreenScale: scale;
    CGFloat flattedValue =ceil(floatValue * scale) / scale;
    return flattedValue;
}

CG_INLINE CGFloat
TT_FontScale(CGFloat floatValue){
    return TT_FontSizeScale(floatValue, 0);
}

CG_INLINE CGRect
TT_FontSizeRectConfigureWidth(CGRect rect,CGFloat width){
    rect.size.width = TT_FontScale(width);
    return rect;
}

CG_INLINE void
ReplaceMethod(Class TT_class,SEL TT_originSelector,SEL TT_newSelector){
    Method originMethod =class_getInstanceMethod(TT_class, TT_originSelector);
    Method newMethod =class_getInstanceMethod(TT_class, TT_newSelector);
    
    BOOL isAddedMethod =class_addMethod(TT_class, TT_originSelector,method_getImplementation(newMethod),method_getTypeEncoding(newMethod));
    
    if(isAddedMethod){
        class_replaceMethod(TT_class, TT_newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, newMethod);
    }
}

@interface UIViewController (TT_familyFontSizeConfigura)

@property(nonatomic,strong)NSMutableDictionary *TT_keyCacheDic_Portrait;

@property(nonatomic,strong)NSMutableDictionary *TT_keyCacheDic_Landscape;

@property(nonatomic,strong)NSMutableArray *TT_indexCacheArray_Portrait;

@property(nonatomic,strong)NSMutableArray *TT_indexCacheArray_Landscape;

@property (nonatomic, assign) BOOL isIndexPath;

@end

@implementation UIViewController (TT_familyFontSizeConfigura)

#pragma mark ---- setter && getter

-(NSMutableDictionary *)keyCacheDicForCurrentOrientation{
    return UIInterfaceOrientationIsPortrait([UIDevice currentDevice].orientation) ? self.TT_keyCacheDic_Portrait : self.TT_keyCacheDic_Landscape;
}

-(void)setTT_keyCacheDic_Portrait:(NSMutableDictionary *)TT_keyCacheDic_Portrait{
    objc_setAssociatedObject(self, @selector(TT_keyCacheDic_Portrait),TT_keyCacheDic_Portrait, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableDictionary *)TT_keyCacheDic_Portrait{
    return  objc_getAssociatedObject(self, _cmd);
}

-(void)setTT_keyCacheDic_Landscape:(NSMutableDictionary *)TT_keyCacheDic_Landscape{
    objc_setAssociatedObject(self, @selector(TT_keyCacheDic_Landscape), TT_keyCacheDic_Landscape, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableDictionary *)TT_keyCacheDic_Landscape{
    return objc_getAssociatedObject(self, _cmd);
}

@end
