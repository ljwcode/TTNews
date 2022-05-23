//
//  TTPlayerMaskView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPlayerMaskView.h"

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
    [self.bottomToolBar addSubview:self.volumeButton];
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

- (void)makeConstraints{
   
    [self.topToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(ToolBarHeight);
    }];
  
    [self .bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(ToolBarHeight);
    }];
    
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(hSpace);
        make.bottom.mas_equalTo(-vSpace);
        make.width.equalTo(self.backButton.mas_height);
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.center.equalTo(self);
    }];
   
    [self.volumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(hSpace);
        make.bottom.mas_equalTo(-vSpace);
        make.width.equalTo(self.backButton.mas_height);
    }];
    
    
    [self.fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-hSpace);
        make.top.mas_equalTo(vSpace);
        make.width.equalTo(self.backButton.mas_height);
    }];
    
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.volumeButton.mas_right).offset(hSpace);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.bottomToolBar);
    }];
    
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.fullButton.mas_left).offset(-hSpace);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.bottomToolBar);
    }];
   
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTimeLabel.mas_right).offset(hSpace);
        make.right.equalTo(self.totalTimeLabel.mas_left).offset(-hSpace);
        make.height.mas_equalTo(2);
        make.centerY.equalTo(self.bottomToolBar);
    }];
   
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.progress);
    }];
    
    [self.failButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}



#pragma mark - lazy load

- (UIView *) topToolBar{
    if (!_topToolBar){
        _topToolBar = [[UIView alloc] init];
        _topToolBar.userInteractionEnabled = YES;
    }
    return _topToolBar;
}
//底部工具条
- (UIView *) bottomToolBar{
    if (!_bottomToolBar){
        _bottomToolBar = [[UIView alloc] init];
        _bottomToolBar.userInteractionEnabled = YES;
    }
    return _bottomToolBar;
}
//加载动画
- (UIActivityIndicatorView *) activity{
    if (!_activity){
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_activity startAnimating];
    }
    return _activity;
}
//返回按钮
- (UIButton *) backButton{
    if (!_backButton){
        _backButton.hidden = YES;
        _backButton = [[UIButton alloc] init];
    }
    return _backButton;
}
//播放按钮
- (UIButton *) playButton{
    if (!_playButton){
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
    if (!_volumeButton){
        _volumeButton = [[UIButton alloc] init];
        [_volumeButton setImage:[UIImage imageNamed:@"TT_play"] forState:UIControlStateNormal];
        [_volumeButton setImage:[UIImage imageNamed:@"TT_mute"] forState:UIControlStateSelected];
        [_volumeButton addTarget:self action:@selector(volumeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _volumeButton;
}

//全屏按钮
- (UIButton *) fullButton{
    if (!_fullButton){
        _fullButton = [[UIButton alloc] init];
        [_fullButton setImage:[UIImage imageNamed:@"TTMaxPlayer"] forState:UIControlStateNormal];
        [_fullButton setImage:[UIImage imageNamed:@"TTMinPlayer"] forState:UIControlStateSelected];
        [_fullButton addTarget:self action:@selector(fullButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullButton;
}
//当前播放时间
- (UILabel *) currentTimeLabel{
    if (!_currentTimeLabel){
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
    if (!_totalTimeLabel){
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
    if (!_progress){
        _progress = [[UIProgressView alloc] init];
        _progress.trackTintColor = ProgressColor;
        _progress.progressTintColor = ProgressTintColor;
    }
    return _progress;
}
//滑动条
- (TTSlider *) slider{
    if (!_slider){
        _slider = [[TTSlider alloc] init];

        [_slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        _slider.minimumTrackTintColor = PlayFinishColor;
        _slider.maximumTrackTintColor = [UIColor clearColor];
    }
    return _slider;
}
//加载失败按钮
- (UIButton *) failButton{
    if (!_failButton) {
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

- (void)backButtonAction:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_backButtonAction:)]) {
        [self.delegate TT_backButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

- (void)playButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_playButtonAction:)]) {
        [self.delegate TT_playButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

- (void)volumeButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_volumButtonAction:)]) {
        [self.delegate TT_volumButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

- (void)fullButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_fullButtonAction:)]) {
        [self.delegate TT_fullButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

- (void)failButtonAction:(UIButton *)button{
    self.failButton.hidden = YES;
    [self.activity startAnimating];
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_failButtonAction:)]) {
        [self.delegate TT_failButtonAction:button];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

- (void)progressSliderTouchBegan:(TTSlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_progressSliderTouchBegan:)]) {
        [self.delegate TT_progressSliderTouchBegan:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

- (void)progressSliderValueChanged:(TTSlider *)slider{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TT_progressSliderValueChanged:)]) {
        [self.delegate TT_progressSliderValueChanged:slider];
    }else{
        NSLog(@"没有实现代理或者没有设置代理人");
    }
}

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
