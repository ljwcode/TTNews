//
//  TTPageMenuItem.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPageMenuItem : UICollectionViewCell

@property(nonatomic,assign,getter = itemSelected)BOOL itemSelected;

-(void)setSelected:(BOOL)selected withAnimation:(BOOL)isAnimation;

#pragma mark -- item 相关属性

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,copy)void(^menuItemNormalStyleBlock)(void);

@property(nonatomic,copy)void(^menuItemSelectedStyleBlock)(void);

@property(nonatomic,copy)void(^menuItemNormalStyleAnimationBlock)(void);

@property(nonatomic,copy)void(^menuItemSelectedStyleAnimationBlock)(void);

@end

NS_ASSUME_NONNULL_END
