//
//  TTTabBarView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TTItemButtonBlock)(NSInteger item);

@interface TTTabBarView : UIView

@property(nonatomic,copy)TTItemButtonBlock block;

-(void)TT_itemButton:(NSInteger)item itemBlock:(TTItemButtonBlock)itemBlock;

@end

NS_ASSUME_NONNULL_END
