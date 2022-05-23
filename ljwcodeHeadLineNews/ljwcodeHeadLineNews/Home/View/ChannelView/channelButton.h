//
//  channelButton.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newsChannelModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface channelButton : UIButton

@property(nonatomic,strong)UIImageView *deleteImageView;//删除状态图片

@property(nonatomic,strong)newsChannelModel *channelModel;

-(instancetype)initWithMyChannelBlock:(void(^)(channelButton *))channelBlock recommendChannelBlock:(void(^)(channelButton *))recommendChannelBlock;

-(void)longPressGestureWithChannelBeginBlock:(void(^)(channelButton *))channelBeginBlock channelMoveBlock:(void(^)(channelButton *,UILongPressGestureRecognizer *longPreGes))channelMoveBlock channelEndBlock:(void(^)(channelButton *))channelEndBlock;

-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
