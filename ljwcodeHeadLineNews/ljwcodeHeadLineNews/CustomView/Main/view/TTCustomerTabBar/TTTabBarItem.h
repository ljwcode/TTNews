//
//  TTTabBarItem.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/19.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTTabBarItem : UIView

-(instancetype)initWithItemTitle:(NSString *)ItemTitle normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg imgSize:(CGSize)imgSize;

-(void)tabBarItemSelected:(BOOL)selected selectedIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
