//
//  TTStatusView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/13.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TTStatusViewDelegate <NSObject>

- (void)statusViewSelectIndex:(NSInteger)index;

@end

@interface TTStatusView : UIView

@property(nonatomic,assign)BOOL isScroll;

@property(nonatomic,weak)id<TTStatusViewDelegate>delegate;

- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor;

-(void)changeTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
