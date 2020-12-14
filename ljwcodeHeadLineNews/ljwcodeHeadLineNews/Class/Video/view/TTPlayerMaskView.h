//
//  TTPlayerMaskView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSlider.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TTPlayerMaskViewDelegate <NSObject>
/**返回按钮代理*/
- (void)TT_backButtonAction:(UIButton *)button;
/**播放按钮代理*/
- (void)TT_playButtonAction:(UIButton *)button;
/**全屏按钮代理*/
- (void)TT_fullButtonAction:(UIButton *)button;
/**开始滑动*/
- (void)TT_progressSliderTouchBegan:(TTSlider *)slider;
/**滑动中*/
- (void)TT_progressSliderValueChanged:(TTSlider *)slider;
/**滑动结束*/
- (void)TT_progressSliderTouchEnded:(TTSlider *)slider;
/**失败按钮代理*/
- (void)TT_failButtonAction:(UIButton *)button;

/**静音播放**/
- (void)TT_volumButtonAction:(UIButton *)button;
@end

@interface TTPlayerMaskView : UIButton

/**顶部工具条*/
@property (nonatomic,strong) UIView *topToolBar;
/**底部工具条*/
@property (nonatomic,strong) UIView *bottomToolBar;
/**转子*/
@property (nonatomic,strong) UIActivityIndicatorView *activity;
/**顶部工具条返回按钮*/
@property (nonatomic,strong) UIButton *backButton;
/**底部工具条播放按钮*/
@property (nonatomic,strong) UIButton *playButton;
/**底部工具条全屏按钮*/
@property (nonatomic,strong) UIButton *fullButton;
/**底部工具条当前播放时间*/
@property (nonatomic,strong) UILabel *currentTimeLabel;
/**底部工具条视频总时间*/
@property (nonatomic,strong) UILabel *totalTimeLabel;
/**缓冲进度条*/
@property (nonatomic,strong) UIProgressView *progress;
/**播放进度条*/
@property (nonatomic,strong) TTSlider *slider;
/**加载失败按钮*/
@property (nonatomic,strong) UIButton *failButton;

/**静音按钮*/
@property (nonatomic,strong) UIButton *volumeButton;

/**代理人*/
@property (nonatomic,weak) id<TTPlayerMaskViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
