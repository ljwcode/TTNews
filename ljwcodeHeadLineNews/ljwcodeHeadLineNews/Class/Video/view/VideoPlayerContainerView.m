//
//  VideoPlayerContainerView.m
//  videoPlayerDemo
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "VideoPlayerContainerView.h"
#import <AVKit/AVKit.h>

#import "NetworkSpeedMonitor.h"
#import "videoPlayerToolView.h"

@interface VideoPlayerContainerView ()<VideoPlayerToolsViewDelegate>

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) NetworkSpeedMonitor *speedMonitor;//网速监听
@property (nonatomic, strong) UILabel *speedTextLabel;//显示网速Label
@property (nonatomic, strong) videoPlayerToolView *vpToolsView;//工具条

@property (nonatomic, strong) id playbackObserver;
@property (nonatomic) BOOL buffered;//是否缓冲完毕

@end

@implementation VideoPlayerContainerView

//设置播放地址
-(void)setUrlVideo:(NSString *)urlVideo{
    
    [self.player seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.player play];//开始播放视频
    
    [self.speedMonitor startNetworkSpeedMonitor];//开始监听网速
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkSpeedChanged:) name:NetworkDownloadSpeedNotificationKey object:nil];
    
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:urlVideo]];
    [self vpc_addObserverToPlayerItem:item];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.player replaceCurrentItemWithPlayerItem:item];
        [self vpc_playerItemAddNotification];
    });
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.layer addSublayer:self.playerLayer];
        [self addSubview:self.speedTextLabel];
        [self addSubview:self.vpToolsView];
    }
    return self;
}

- (void)networkSpeedChanged:(NSNotification *)sender {
    NSString *downloadSpped = [sender.userInfo objectForKey:NetworkSpeedNotificationKey];
    self.speedTextLabel.text = downloadSpped;
}

#pragma mark - 工具条
-(videoPlayerToolView *)vpToolsView{
    if (!_vpToolsView) {
        _vpToolsView = [[videoPlayerToolView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 40, CGRectGetWidth(self.frame), 40)];
        _vpToolsView.delegate = self;
        
        [_vpToolsView.progressSlider addTarget:self action:@selector(vpc_sliderTouchBegin:) forControlEvents:UIControlEventTouchDown];
        [_vpToolsView.progressSlider addTarget:self action:@selector(vpc_sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_vpToolsView.progressSlider addTarget:self action:@selector(vpc_sliderTouchEnd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vpToolsView;
}

#pragma mark ------- VideoPlayerToolsViewDelegate

-(void)playButtonWithStates:(BOOL)state{
    if (state) {
        [self.player pause];
    }else{
        [self.player play];
    }
}

- (void)vpc_sliderTouchBegin:(UISlider *)sender {
    [self.player pause];
}

- (void)vpc_sliderValueChanged:(UISlider *)sender {
    
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * _vpToolsView.progressSlider.value;
    NSInteger currentMin = currentTime / 60;
    NSInteger currentSec = (NSInteger)currentTime % 60;
    _vpToolsView.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec];
    
}

- (void)vpc_sliderTouchEnd:(UISlider *)sender {
    
    NSTimeInterval slideTime = CMTimeGetSeconds(self.player.currentItem.duration) * _vpToolsView.progressSlider.value;
    if (slideTime == CMTimeGetSeconds(self.player.currentItem.duration)) {
        slideTime -= 0.5;
    }
    [self.player seekToTime:CMTimeMakeWithSeconds(slideTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [self.player play];
    
}

#pragma mark - 网速监听器
- (NetworkSpeedMonitor *)speedMonitor {
    if (!_speedMonitor) {
        _speedMonitor = [[NetworkSpeedMonitor alloc] init];
    }
    return _speedMonitor;
}

#pragma mark - 显示网速Label
- (UILabel *)speedTextLabel {
    if (!_speedTextLabel) {
        _speedTextLabel = [UILabel new];
        _speedTextLabel.frame = CGRectMake(0, 0, self.frame.size.width, 20);
        _speedTextLabel.textColor = [UIColor whiteColor];
        _speedTextLabel.font = [UIFont systemFontOfSize:12.0];
        _speedTextLabel.textAlignment = NSTextAlignmentCenter;
        _speedTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _speedTextLabel;
    
}

#pragma mark - AVPlayer
-(AVPlayer *)player{
    
    if (!_player) {
        _player = [[AVPlayer alloc] init];
        __weak typeof(self) weakSelf = self;
        // 每秒回调一次
        self.playbackObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
            [weakSelf vpc_setTimeLabel];
            NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.player.currentItem.duration);//总时长
            NSTimeInterval currentTime = time.value / time.timescale;//当前时间进度
            weakSelf.vpToolsView.progressSlider.value = currentTime / totalTime;
        }];
    }
    return _player;
}

#pragma mark - AVPlayerLayer
-(AVPlayerLayer *)playerLayer{
    
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _playerLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    return _playerLayer;
    
}


#pragma mark - lTime

- (void)vpc_setTimeLabel {
    
    NSTimeInterval totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//总时长
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);//当前时间进度
    // 切换视频源时totalTime/currentTime的值会出现nan导致时间错乱
    if (!(totalTime >= 0) || !(currentTime >= 0)) {
        totalTime = 0;
        currentTime = 0;
    }
    
    NSInteger totalMin = totalTime / 60;
    NSInteger totalSec = (NSInteger)totalTime % 60;
    NSString *totalTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",totalMin,totalSec];
    
    NSInteger currentMin = currentTime / 60;
    NSInteger currentSec = (NSInteger)currentTime % 60;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02ld:%02ld",currentMin,currentSec];
    
    _vpToolsView.timeLabel.text = [NSString stringWithFormat:@"%@/%@",currentTimeStr,totalTimeStr];
    
}

#pragma mark - Observer

- (void)vpc_playerItemAddNotification {
    // 播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vpc_playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)vpc_playbackFinished:(NSNotification *)noti{
    [self.player pause];
}

- (void)vpc_addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    // 监听播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 监听缓冲进度
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)vpc_playerItemRemoveNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)vpc_playerItemRemoveObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            [self vpc_setTimeLabel];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = self.player.currentItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);//本次缓冲起始时间
        NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);//缓冲时间
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        float totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//视频总长度
        float progress = totalBuffer/totalTime;//缓冲进度
        NSLog(@"progress = %lf",progress);
        
        //如果缓冲完了，拖动进度条不需要重新显示缓冲条
        if (!self.buffered) {
            if (progress == 1.0) {
                self.buffered = YES;
            }
            [self.vpToolsView.bufferProgressView setProgress:progress];
        }
        NSLog(@"yon = %@",self.buffered ? @"yes" : @"no");
    }
}

- (void)dealloc {
    
    [self.speedMonitor stopNetworkSpeedMonitor];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkDownloadSpeedNotificationKey object:nil];
    
    [self.player removeTimeObserver:self.playbackObserver];
    [self vpc_playerItemRemoveObserver];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
