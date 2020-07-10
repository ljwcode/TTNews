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

/*
 1:普通短视频
 2:电视剧
 */

@implementation videoPlayerToolView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
        [self addSubview:self.playPauseBtn];
        [self addSubview:self.playerProgressView];
        [self addSubview:self.playerSlider];
        [self addSubview:self.playerTimeLabel];
    }
    return self;
}

-(UIButton *)playPauseBtn{
    if(!_playPauseBtn){
        _playPauseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.width)];
        [_playPauseBtn setImage:[UIImage imageNamed:@"new_play_video_44x44_"] forState:UIControlStateNormal];
        [_playPauseBtn addTarget:self action:@selector(playPauseBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playPauseBtn;
}

-(void)playPauseBtnHandle:(UIButton *)sender{
    sender.selected = !sender.selected;
    //
    if(sender.selected){
        [sender setImage:[UIImage imageNamed:@"new_play_video_44x44_"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"new_pause_video_60x60_"] forState:UIControlStateNormal];
    }
    if([self.delegate respondsToSelector:@selector(videoPlayerAction:)]){
        [self.delegate videoPlayerAction:sender.selected];
    }
}

-(UIProgressView *)playerProgressView{
    if(!_playerProgressView){
        _playerProgressView = [[UIProgressView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.playPauseBtn.frame)+20, CGRectGetMidY(self.playPauseBtn.frame), 200, 4)];
        _playerProgressView.progressTintColor = [UIColor whiteColor];
        _playerProgressView.trackTintColor = [UIColor cyanColor];
    }
    
    return _playerProgressView;
}

-(UISlider *)playerSlider{
    if(!_playerSlider){
        _playerSlider = [[UISlider alloc]initWithFrame:CGRectMake(self.playerProgressView.frame.origin.x, CGRectGetMidY(self.playerProgressView.frame), 200, 20)];
        _playerSlider.backgroundColor = [UIColor lightGrayColor];
        _playerSlider.maximumTrackTintColor = [UIColor cyanColor];
        _playerSlider.minimumTrackTintColor = [UIColor whiteColor];
        [_playerSlider setThumbImage:[UIImage imageNamed:@"pointer_x2_60x60"] forState:UIControlStateNormal];
    }
    return _playerSlider;
}
-(UILabel *)playerTimeLabel{
    if(!_playerTimeLabel){
        _playerTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.playerSlider.frame)+20, CGRectGetMidY(self.playerSlider.frame), self.playerSlider.frame.size.width/4, 20)];
        _playerTimeLabel.text = @"00:00/00:00";
        _playerTimeLabel.textColor = [UIColor whiteColor];
        _playerTimeLabel.font = [UIFont systemFontOfSize:12.f];
        _playerTimeLabel.highlighted = YES;
    }
    return _playerTimeLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
