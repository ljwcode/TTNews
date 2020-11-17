//
//  videoPlayerItemView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VideoPlayerToolsViewDelegate <NSObject>

-(void)playButtonWithStates:(BOOL)state;

@end

@interface videoPlayerToolView : UIView

@property (nonatomic, strong) UIButton *playerBtn;//播放暂停按钮
@property (nonatomic, strong) UISlider *progressSlider;//进度条
@property (nonatomic, strong) UIProgressView *bufferProgressView;//缓冲条
@property (nonatomic, strong) UILabel *videoTimeLabel;//时间进度和总时长

@property (nonatomic, weak) id<VideoPlayerToolsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
