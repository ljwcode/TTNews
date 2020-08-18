//
//  TTPageDecorateView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPageDecorateView : UIView

@property(nonatomic,weak)UIScrollView *scrollView;

-(void)moveToIndex:(NSInteger)index withAnimation:(BOOL)animation;

-(void)setDecorateView:(UIView *)decorateView withDecorateCount:(NSInteger)decorateCount withDecorateSize:(CGSize)decorateSize;

@end

NS_ASSUME_NONNULL_END
