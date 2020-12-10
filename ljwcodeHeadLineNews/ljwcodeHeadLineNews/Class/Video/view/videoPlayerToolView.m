//
//  videoPlayerItemView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoPlayerToolView.h"

@interface videoPlayerToolView ()

@end

@implementation videoPlayerToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self createUI];//创建UI
    }
    return self;
    
}

#pragma mark - 创建UI
-(void)createUI{
    [self addSubview:self.playerChackBtn];//开始暂停按钮
    [self addSubview:self.bufferProgressView];//缓冲条
    [self addSubview:self.progressSlider];//创建进度条
    [self addSubview:self.timeLabel];//视频时间
//    [self addSubview:self.fullScreenBtn];//全屏设置
}

#pragma mark - lazy load

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.frame = CGRectMake(CGRectGetMaxX(_progressSlider.frame)+10, 0, self.frame.size.width - CGRectGetWidth(_progressSlider.frame) - 40 - CGRectGetWidth(_playerChackBtn.frame), self.frame.size.height);
        _timeLabel.text = @"00:00/00:00";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLabel;
    
}

-(UISlider *)progressSlider{
    if (!_progressSlider) {
        _progressSlider = [UISlider new];
        _progressSlider.frame = CGRectMake(CGRectGetMinX(_bufferProgressView.frame) - 2, CGRectGetMidY(_bufferProgressView.frame) - 10, 10, 10);
        _progressSlider.maximumTrackTintColor = [UIColor clearColor];
        _progressSlider.minimumTrackTintColor = [UIColor whiteColor];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"point"] forState:0];
    }
    return _progressSlider;
}

-(UIProgressView *)bufferProgressView{
    if (!_bufferProgressView) {
        _bufferProgressView = [UIProgressView new];
        _bufferProgressView.frame = CGRectMake(CGRectGetMaxX(_playerChackBtn.frame) + 20, CGRectGetMidY(_playerChackBtn.frame) - 2, kScreenWidth-CGRectGetMaxX(_playerChackBtn.frame)-20*2-100, 4);
        _bufferProgressView.trackTintColor = [UIColor grayColor];
        _bufferProgressView.progressTintColor = [UIColor cyanColor];
    }
    return _bufferProgressView;
    
}

-(UIButton *)playerChackBtn{
    if (!_playerChackBtn) {
        _playerChackBtn = [UIButton new];
        _playerChackBtn.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        [_playerChackBtn setImage:[UIImage imageNamed:@"Pause"] forState:0];
        [_playerChackBtn addTarget:self action:@selector(btnCheckSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerChackBtn;
}

-(UIButton *)fullScreenBtn{
    if(!_fullScreenBtn){
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenBtn setBackgroundImage:[UIImage imageNamed:@"enlarge_video"] forState:UIControlStateNormal];
//        _fullScreenBtn setFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    return _fullScreenBtn;
}

-(void)btnCheckSelect:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [_playerChackBtn setImage:[UIImage imageNamed:@"Player"] forState:UIControlStateNormal];
    }else{
        [_playerChackBtn setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    }
    if ([_delegate respondsToSelector:@selector(playButtonWithStates:)]) {
        [_delegate playButtonWithStates:sender.selected];
    }
}
@end
