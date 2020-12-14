//
//  TTPlayerMaskView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPlayerMaskView.h"

//间隙
#define Padding        10
//顶部底部工具条高度
#define ToolBarHeight     40
//进度条颜色
#define ProgressColor     [UIColor colorWithRed:0.54118 green:0.51373 blue:0.50980 alpha:1.00000]
//缓冲颜色
#define ProgressTintColor [UIColor orangeColor]
//播放完成颜色
#define PlayFinishColor   [UIColor whiteColor]

@interface TTPlayerMaskView()


@end

@implementation TTPlayerMaskView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}
- (void)initViews{
    [self addSubview:self.topToolBar];
    [self addSubview:self.bottomToolBar];
    [self addSubview:self.activity];
    [self.topToolBar addSubview:self.backButton];
    [self.bottomToolBar addSubview:self.volumeButton];//声音按钮，控制是否静音
    [self.bottomToolBar addSubview:self.fullButton];
    [self.bottomToolBar addSubview:self.currentTimeLabel];
    [self.bottomToolBar addSubview:self.totalTimeLabel];
    [self.bottomToolBar addSubview:self.progress];
    [self.bottomToolBar addSubview:self.slider];
    [self addSubview:self.failButton];
    [self addSubview:self.playButton];
    
    [self makeConstraints];
    
    self.topToolBar.backgroundColor = [UIColor clearColor];
    
    self.bottomToolBar.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
    
}
#pragma mark - 约束
- (void)makeConstraints{
    //顶部工具条
    [self.topToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(ToolBarHeight);
    }];
    //底部工具条
    [self .bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(ToolBarHeight);
    }];
    //转子
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    //返回按钮
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(Padding);
        make.bottom.mas_equalTo(-Padding);
        make.width.equalTo(self.backButton.mas_height);
    }];
    //播放按钮
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.equalTo(self);
    }];
    //声音按钮
    [self.volumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(Padding);
        make.bottom.mas_equalTo(-Padding);
        make.width.equalTo(self.backButton.mas_height);
    }];
    
    //全屏按钮
    [self.fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-Padding);
        make.top.mas_equalTo(Padding);
        make.width.equalTo(self.backButton.mas_height);
    }];
    //当前播放时间
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.volumeButton.mas_right).offset(Padding);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.bottomToolBar);
    }];
    //总时间
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fullButton.mas_left).offset(-Padding);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.bottomToolBar);
    }];
    //缓冲条
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(Padding);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-Padding);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self.bottomToolBar);
    }];
    //滑杆
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.progress);
    }];
    //失败按钮
    [self.failButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}



#pragma mark - 懒加载
//顶部工具条
- (UIView *) topToolBar{
    if (_topToolBar == nil){
        _topToolBar = [[UIView alloc] init];
        _topToolBar.userInteractionEnabled = YES;
    }
    return _topToolBar;
}
//底部工具条
- (UIView *) bottomToolBar{
    if (_bottomToolBar == nil){
        _bottomToolBar = [[UIView alloc] init];
        _bottomToolBar.userInteractionEnabled = YES;
    }
    return _bottomToolBar;
}
//转子
- (UIActivityIndicatorView *) activity{
    if (_activity == nil){
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activity startAnimating];
    }
    return _activity;
}
//返回按钮
- (UIButton *) backButton{
    if (_backButton == nil){
        _backButton.hidden = YES;
        _backButton = [[UIButton alloc] init];
    }
    return _backButton;
}
//播放按钮
- (UIButton *) playButton{
    if (_playButton == nil){
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"TT_video_play"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"TT_video_pause"] forState:UIControlStateHighlighted];
        [_playButton setImage:[UIImage imageNamed:@"TT_video_0"] forState:UIControlStateSelected];
        _playButton.hidden = YES;
        [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

//声音按钮
- (UIButton *) volumeButton{
    if (_volumeButton == nil){
        _volumeButton = [[UIButton alloc] init];
        [_volumeButton setImage:[UIImage imageNamed:@"TT_play"] forState:UIControlStateNormal];
        [_volumeButton setImage:[UIImage imageNamed:@"TT_mute"] forState:UIControlStateSelected];
        [_volumeButton addTarget:self action:@selector(volumeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _volumeButton;
}

//全屏按钮
- (UIButton *) fullButton{
    if (_fullButton == nil){
        _fullButton = [[UIButton alloc] init];
        [_fullButton setImage:[UIImage imageNamed:@"TTMaxPlayer"] forState:UIControlStateNormal];
        [_fullButton setImage:[UIImage imageNamed:@"TTMinPlayer"] forState:UIControlStateSelected];
        [_fullButton addTarget:self action:@selector(fullButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullButton;
}
//当前播放时间
- (UILabel *) currentTimeLabel{
    if (_currentTimeLabel == nil){
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font      = [UIFont systemFontOfSize:12];
        _currentTimeLabel.text      = @"00:00";
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
//总时间
- (UILabel *) totalTimeLabel{
    if (_totalTimeLabel == nil){
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font      = [UIFont systemFontOfSize:12];
        _totalTimeLabel.text      = @"00:00";
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}
//缓冲条
- (UIProgressView *) progress{
    if (_progress == nil){
        _progress = [[UIProgressView alloc] init];
        _progress.trackTintColor = ProgressColor;
        _progress.progressTintColor = ProgressTintColor;
    }
    return _progress;
}
//滑动条
- (TTSlider *) slider{
    if (_slider == nil){
        _slider = [[TTSlider alloc] init];
        // slider开始滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        //左边颜色
        _slider.minimumTrackTintColor = PlayFinishColor;
        //右边颜色
        _slider.maximumTrackTintColor = [UIColor clearColor];
    }
    return _slider;
}
//加载失败按钮
- (UIButton *) failButton
{
    if (_failButton == nil) {
        _failButton = [[UIButton alloc] init];
        _failButton.hidden = YES;
        [_failButton setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _failButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _failButton.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
        [_failButton addTarget:self action:@selector(failButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failButton;
}

#pragma mark - 响应事件
//返回按钮
- (void)backButtonAction:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_backButtonAction:)]) {
        [self.delegate TT_backButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//播放按钮
- (void)playButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_playButtonAction:)]) {
        [self.delegate TT_playButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//声音按钮
- (void)volumeButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_volumButtonAction:)]) {
        [self.delegate TT_volumButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

//全屏按钮
- (void)fullButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_fullButtonAction:)]) {
        [self.delegate TT_fullButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//失败按钮
- (void)failButtonAction:(UIButton *)button{
    self.failButton.hidden = YES;
    [self.activity startAnimating];
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_failButtonAction:)]) {
        [self.delegate TT_failButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
#pragma mark - 滑杆
//开始滑动
- (void)progressSliderTouchBegan:(TTSlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_progressSliderTouchBegan:)]) {
        [self.delegate TT_progressSliderTouchBegan:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//滑动中
- (void)progressSliderValueChanged:(TTSlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_progressSliderValueChanged:)]) {
        [self.delegate TT_progressSliderValueChanged:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}
//滑动结束
- (void)progressSliderTouchEnded:(TTSlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_progressSliderTouchEnded:)]) {
        [self.delegate TT_progressSliderTouchEnded:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
