//
//  TT_ClickHightLightTableViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/7.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TTHomeNewsTableViewDelegate <NSObject>

@optional

-(void)TTDeleteNewsCellHandle;

-(void)TTPlayNewsVideoHandle;

-(void)TTMicroToutiaoShareHandle;

-(void)TTMicroToutiaoCommentHandle;

-(void)TTMicroToutiaoLikeHandle;

@end

@interface TT_ClickHightLightTableViewCell : UITableViewCell

@property(nonatomic,assign)id<TTHomeNewsTableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
