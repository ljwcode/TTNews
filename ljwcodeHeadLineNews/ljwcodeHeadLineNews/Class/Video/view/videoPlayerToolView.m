//
//  videoPlayerItemView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoPlayerToolView.h"

@interface videoPlayerToolView()


@end

@implementation videoPlayerToolView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self createUI];//创建UI
    }
    return self;
    
}

#pragma mark - 创建UI
-(void)createUI{
    [self addSubview:self.playerBtn];//开始暂停按钮
    [self addSubview:self.bufferProgressView];//缓冲条
    [self addSubview:self.progressSlider];//创建进度条
    [self addSubview:self.videoTimeLabel];//视频时间
}

#pragma mark - 视频时间
-(UILabel *)videoTimeLabel{
    
    if (!_videoTimeLabel) {
        _videoTimeLabel = [UILabel new];
        _videoTimeLabel.frame = CGRectMake(CGRectGetMaxX(_progressSlider.frame)+10, 0, self.frame.size.width - CGRectGetWidth(_progressSlider.frame) - 40 - CGRectGetWidth(_playerBtn.frame), self.frame.size.height);
        _videoTimeLabel.text = @"00:00/00:00";
        _videoTimeLabel.textColor = [UIColor whiteColor];
        _videoTimeLabel.textAlignment = NSTextAlignmentCenter;
        _videoTimeLabel.font = [UIFont systemFontOfSize:12];
        _videoTimeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _videoTimeLabel;
    
}

#pragma mark - 创建进度条
-(UISlider *)progressSlider{
    
    if (!_progressSlider) {
        _progressSlider = [UISlider new];
        _progressSlider.frame = CGRectMake(CGRectGetMinX(_bufferProgressView.frame) - 2, CGRectGetMidY(_bufferProgressView.frame) - 10, CGRectGetWidth(_bufferProgressView.frame) - 4, 20);
        _progressSlider.maximumTrackTintColor = [UIColor clearColor];
        _progressSlider.minimumTrackTintColor = [UIColor whiteColor];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"point"] forState:0];
    }
    return _progressSlider;
    
}

#pragma mark - 缓冲条
-(UIProgressView *)bufferProgressView{
    
    if (!_bufferProgressView) {
        _bufferProgressView = [UIProgressView new];
        _bufferProgressView.frame = CGRectMake(CGRectGetMaxX(_playerBtn.frame) + 20, CGRectGetMidY(_playerBtn.frame) - 2, kScreenWidth-CGRectGetMaxX(_playerBtn.frame)-20*2-100, 4);
        _bufferProgressView.trackTintColor = [UIColor grayColor];
        _bufferProgressView.progressTintColor = [UIColor cyanColor];
    }
    return _bufferProgressView;
    
}

#pragma mark - 开始暂停按钮
-(UIButton *)playerBtn{
    
    if (!_playerBtn) {
        _playerBtn = [UIButton new];
        _playerBtn.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        [_playerBtn setImage:[UIImage imageNamed:@"Pause"] forState:0];
        [_playerBtn addTarget:self action:@selector(btnCheckSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playerBtn;
    
}

-(void)btnCheckSelect:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [_playerBtn setImage:[UIImage imageNamed:@"Player"] forState:UIControlStateNormal];
    }else{
        [_playerBtn setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
    }
    if ([_delegate respondsToSelector:@selector(playButtonWithStates:)]) {
        [_delegate playButtonWithStates:sender.selected];
    }
}

@end
