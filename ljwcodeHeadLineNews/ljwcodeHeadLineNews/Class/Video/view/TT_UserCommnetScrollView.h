//
//  TT_UserCommnetScrollView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TT_UserCommentBlock)(NSArray *modelArray);

@protocol TT_UserCommentDelegate <NSObject>

-(void)TT_RemoveCommentView;

@end

@interface TT_UserCommnetScrollView : UIView

@property(nonatomic,copy)TT_UserCommentBlock commentBlock;

@property(nonatomic,weak)id<TT_UserCommentDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
