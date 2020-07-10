//
//  TVVideoPlayerView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TVVideoPlayerView.h"
#import "NetworkSpeedMonitor.h"
#import "videoPlayerToolView.h"

@interface TVVideoPlayerView()

@property(nonatomic,strong)videoPlayerToolView *playerToolView;

@property(nonatomic,strong)NetworkSpeedMonitor *speedMonitor;

@end

static CGFloat itemSpace = 10;
//点击播放 在表页面播放 点击全屏，进入全屏播放
@implementation TVVideoPlayerView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@""]];
        self.player = [AVPlayer playerWithPlayerItem:_playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        self.playerLayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height-3*itemSpace)/3);
        [self.layer addSublayer:self.playerLayer];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end