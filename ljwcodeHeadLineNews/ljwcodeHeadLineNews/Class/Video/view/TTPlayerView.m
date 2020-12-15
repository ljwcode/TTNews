//
//  TTPlayerView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/14.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPlayerView.h"
#import "TTPlayerMaskView.h"
#import <AVFoundation/AVFoundation.h>
#import "NetworkSpeedMonitor.h"

//消失时间
#define DisappearTime  10

//方向枚举
typedef NS_ENUM(NSInteger,Direction){
    Letf = 0,
    Right,
};

// 播放器的几种状态
typedef NS_ENUM(NSInteger, TTPlayerState) {
    TTPlayerStateFailed,     // 播放失败
    TTPlayerStateBuffering,  // 缓冲中
    TTPlayerStatePlaying,    // 播放中
    TTPlayerStateStopped,    // 停止播放
    TTPlayerStatePause       // 暂停播放
};

@interface TTPlayerView()<TTPlayerMaskViewDelegate>

/**控件原始Farme*/
@property (nonatomic,assign)CGRect customFarme;
/** 播发器的几种状态 */
@property (nonatomic,assign)TTPlayerState state;
/**父类控件*/
@property (nonatomic,strong)UIView *fatherView;
/**视频拉伸模式*/
@property (nonatomic,copy)NSString *videoFillMode;

/**全屏标记*/
@property (nonatomic,assign)BOOL isFullScreen;
/**横屏标记*/
@property (nonatomic,assign)BOOL landscape;
/**工具条隐藏标记*/
@property (nonatomic,assign)BOOL isDisappear;
/**用户点击播放标记*/
@property (nonatomic,assign)BOOL isUserPlay;

/**播放器*/
@property (nonatomic,strong) AVPlayer *player;
/**playerLayer*/
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
/**播放器item*/
@property (nonatomic,strong) AVPlayerItem *playerItem;
/**遮罩*/
@property (nonatomic,strong) TTPlayerMaskView *maskView;
/**轻拍定时器*/
@property (nonatomic,strong) NSTimer *timer;
/**slider定时器*/
@property (nonatomic,strong) NSTimer *sliderTimer;

/**返回按钮回调*/
@property (nonatomic,copy) void (^BackBlock) (UIButton *backButton);
/**播放完成回调*/
@property (nonatomic,copy) void (^EndBlock) (void);

@property (nonatomic, strong) NetworkSpeedMonitor *speedMonitor;//网速监听

@property (nonatomic, strong) UILabel *speedTextLabel;//显示网速Label

@end

@implementation TTPlayerView

#pragma mark ----- lazy load

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
        
        _speedTextLabel.textColor = [UIColor whiteColor];
        _speedTextLabel.font = [UIFont systemFontOfSize:12.0];
        _speedTextLabel.textAlignment = NSTextAlignmentCenter;
        _speedTextLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _speedTextLabel;
    
}

//遮罩
- (TTPlayerMaskView *) maskView{
    if (!_maskView){
        _maskView          = [[TTPlayerMaskView alloc] init];
        _maskView.delegate = self;
        [_maskView addTarget:self action:@selector(disappearAction:) forControlEvents:UIControlEventTouchUpInside];
        //计时器，循环执行
        _sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                        target:self
                                                      selector:@selector(timeStack)
                                                      userInfo:nil
                                                       repeats:YES];
        //定时器，工具条消失
        _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                                  target:self
                                                selector:@selector(disappear)
                                                userInfo:nil
                                                 repeats:NO];
    }
    return _maskView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _isFullScreen   = NO;
        _autoFullScreen = YES;
        _repeatPlay     = NO;
        _isLandscape    = NO;
        _landscape      = NO;
        _isDisappear    = NO;
        _isUserPlay     = NO;
        //开启
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        //注册屏幕旋转通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
        //APP运行状态通知，将要被挂起 crash:
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        // app进入前台
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appDidEnterPlayground:)
                                                     name:UIApplicationDidBecomeActiveNotification object:nil];
        
        [self creatUI];
    }
    return self;
}
#pragma mark - 视频拉伸方式

-(void)setFillMode:(VideoFillMode)fillMode{
    switch (fillMode){
        case ResizeAspectFill:
            //原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分会被剪切
            _videoFillMode = AVLayerVideoGravityResizeAspectFill;
            break;
        case ResizeAspect:
            //按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
            _videoFillMode = AVLayerVideoGravityResizeAspect;
            break;
        case Resize:
            //拉伸视频内容达到边框占满，但不按原比例拉伸
            _videoFillMode = AVLayerVideoGravityResize;
            break;
    }
}

- (void)setAutoFullScreen:(BOOL)autoFullScreen{
    _autoFullScreen = autoFullScreen;
}

-(void)setIsLandscape:(BOOL)isLandscape{
    _isLandscape = isLandscape;
    _landscape   = isLandscape;
}

- (void)setRepeatPlay:(BOOL)repeatPlay{
    _repeatPlay = repeatPlay;
}

- (void)setUrl:(NSURL *)url{
    _url                      = url;
    self.playerItem           = [AVPlayerItem playerItemWithAsset:[AVAsset assetWithURL:_url]];
    //创建
    _player                   = [AVPlayer playerWithPlayerItem:_playerItem];
    _playerLayer              = [AVPlayerLayer playerLayerWithPlayer:_player];
    //全屏拉伸
    _playerLayer.videoGravity = AVLayerVideoGravityResize;
    //设置静音模式播放声音
    AVAudioSession * session  = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
//    _player.volume = 0; //默认为静音
    if (_videoFillMode){
        _playerLayer.videoGravity = _videoFillMode;
    }
    [self.speedMonitor startNetworkSpeedMonitor];//开始监听网速
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkSpeedChanged:) name:NetworkDownloadSpeedNotificationKey object:nil];
    //放到最下面，防止遮挡
    [self.layer insertSublayer:_playerLayer atIndex:0];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)networkSpeedChanged:(NSNotification *)sender {
    NSString *downloadSpped = [sender.userInfo objectForKey:NetworkSpeedNotificationKey];
    self.speedTextLabel.text = downloadSpped;
}

-(void)setPlayerItem:(AVPlayerItem *)playerItem{
    
    if (_playerItem == playerItem){
        return;
    }
    
    if (_playerItem) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
        [_playerItem removeObserver:self forKeyPath:@"status"];
        [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
        [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
        [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    }
    _playerItem = playerItem;
    if (playerItem) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    }
    
}
- (void)setState:(TTPlayerState)state{
    _state = state;
    if (state == TTPlayerStateBuffering) {
        [self.maskView.activity startAnimating];
        
    }else if (state == TTPlayerStateFailed){
        [self.maskView.activity stopAnimating];
        NSLog(@"加载失败");
        self.maskView.failButton.hidden = NO;
    }else{
        [self.maskView.activity stopAnimating];
        
        if (_isUserPlay) {
            [self playVideo];
        }
    }
}

- (void)creatUI{
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.speedTextLabel];
    [self.speedTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(0);
    }];
    [self addSubview:self.maskView];
}

#pragma mark ----- hide or show status bar

- (void)setStatusBarHidden:(BOOL)hidden{
    hidden = [self prefersStatusBarHidden];
}
-(BOOL)prefersStatusBarHidden{
    return YES;//隐藏状态栏
}

#pragma mark ----- kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        
        if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
            self.state = TTPlayerStatePlaying;
        }
        else if (self.player.currentItem.status == AVPlayerItemStatusFailed) {
            self.state = TTPlayerStateFailed;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        // 计算缓冲进度
        NSTimeInterval timeInterval = [self availableDuration];
        CMTime duration             = self.playerItem.duration;
        CGFloat totalDuration       = CMTimeGetSeconds(duration);
        [self.maskView.progress setProgress:timeInterval / totalDuration animated:NO];

    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        // 当缓冲是空的时候
        if (self.playerItem.playbackBufferEmpty) {
            self.state = TTPlayerStateBuffering;
            [self bufferingSomeSecond];
        }
        
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        // 当缓冲好的时候
        if (self.playerItem.playbackLikelyToKeepUp && self.state == TTPlayerStateBuffering){
            self.state = TTPlayerStatePlaying;
        }
    }
}

#pragma mark - 缓冲较差时候

//卡顿时会走这里
- (void)bufferingSomeSecond{
    self.state = TTPlayerStateBuffering;

    __block BOOL isBuffering = NO;
    if (isBuffering) return;
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self pausePlay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playVideo];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.playerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
        
    });
}
//计算缓冲进度
- (NSTimeInterval)availableDuration{
    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
    CMTimeRange timeRange     = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds        = CMTimeGetSeconds(timeRange.start);
    float durationSeconds     = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result     = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark ---- TTPlayerMaskViewDelegate
//开始
-(void)TT_progressSliderTouchBegan:(TTSlider *)slider{
    //暂停
    [self pausePlay];
    [self destroyTimer];
}
//结束
-(void)TT_progressSliderTouchEnded:(TTSlider *)slider{
    //继续播放
    [self playVideo];
    _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                              target:self
                                            selector:@selector(disappear)
                                            userInfo:nil
                                             repeats:NO];
}
//拖拽中
-(void)TT_progressSliderValueChanged:(TTSlider *)slider{
    //计算出拖动的当前秒数
    CGFloat total = (CGFloat)_playerItem.duration.value / _playerItem.duration.timescale;
    NSInteger dragedSeconds = floorf(total * slider.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(dragedSeconds, 1);
    [_player seekToTime:dragedCMTime];
}

-(void)TT_playButtonAction:(UIButton *)button{
    if (button.selected == NO){
        [self pausePlay];
    }else{
        [self playVideo];
    }
}

-(void)TT_volumButtonAction:(UIButton *)button{
    if (button.selected == NO){
        self.maskView.volumeButton.selected = NO;
        [_player setVolume:0.3];
    }else{
        self.maskView.volumeButton.selected = YES;
        [_player setVolume:0.0];
    }
}

-(void)TT_fullButtonAction:(UIButton *)button{
    _isLandscape = NO;
    if (_isFullScreen == NO){
        [self fullScreenWithDirection:Letf];
    }else{
        [self originalscreen];
    }
    _isLandscape = _landscape;
}

-(void)TT_failButtonAction:(UIButton *)button{
    [self setUrl:_url];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)TT_backButtonAction:(UIButton *)button{
    if (self.BackBlock){
        self.BackBlock(button);
    }
}

#pragma mark - 计时器事件

- (void)timeStack{
    if (_playerItem.duration.timescale != 0){
        //总共时长
        self.maskView.slider.maximumValue = 1;
        //当前进度
        self.maskView.slider.value = CMTimeGetSeconds([_playerItem currentTime]) / (_playerItem.duration.value / _playerItem.duration.timescale);
        //当前时长进度progress
        NSInteger proMin = (NSInteger)CMTimeGetSeconds([_player currentTime]) / 60;//当前秒
        NSInteger proSec = (NSInteger)CMTimeGetSeconds([_player currentTime]) % 60;//当前分钟
        self.maskView.currentTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)proMin, proSec];
        
        //duration 总时长
        NSInteger durMin = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale / 60;//总分钟
        NSInteger durSec = (NSInteger)_playerItem.duration.value / _playerItem.duration.timescale % 60;//总秒
        self.maskView.totalTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)durMin, durSec];
    }
}

- (void)disappearAction:(UIButton *)button{
    //取消定时消失
    [self destroyTimer];
    if (_isDisappear == NO){
        [UIView animateWithDuration:0.5 animations:^{
            self.maskView.topToolBar.alpha    = 0;
            self.maskView.bottomToolBar.alpha = 0;
        }];
    }else{
        //添加定时消失
        _timer = [NSTimer scheduledTimerWithTimeInterval:DisappearTime
                                                  target:self
                                                selector:@selector(disappear)
                                                userInfo:nil
                                                 repeats:NO];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.maskView.topToolBar.alpha    = 1.0;
            self.maskView.bottomToolBar.alpha = 1.0;
        }];
    }
    _isDisappear = !_isDisappear;
}

- (void)disappear{
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.topToolBar.alpha    = 0;
        self.maskView.bottomToolBar.alpha = 0;
    }];
}

- (void)moviePlayDidEnd:(id)sender{
    if (_repeatPlay == NO){
        [self pausePlay];
    }else{
        [self resetPlay];
    }
    if(self.EndBlock){
        self.EndBlock();
    }
}
- (void)endPlay:(EndBolck) end{
    self.EndBlock = end;
}

- (void)backButton:(BackButtonBlock) backButton;{
    self.BackBlock = backButton;
}

- (void)pausePlay{
    self.maskView.playButton.selected = NO;
    self.maskView.playButton.hidden = NO;
    [_player pause];
}

- (void)playVideo{
    _isUserPlay = YES;
    self.maskView.playButton.selected = YES;
    self.maskView.playButton.hidden = NO;
    [_player play];
}

- (void)resetPlay{
    [_player seekToTime:CMTimeMake(0, 1)];
    [self playVideo];
}

- (void)destroyPlayer{
    //销毁定时器
    [self destroyAllTimer];
    //暂停
    [_player pause];
    //清除
    [_player.currentItem cancelPendingSeeks];
    [_player.currentItem.asset cancelLoading];
    //移除
    [self removeFromSuperview];

}

//销毁所有定时器
- (void)destroyAllTimer{
    [_sliderTimer invalidate];
    [_timer invalidate];
    _sliderTimer = nil;
    _timer       = nil;
}
//销毁定时消失定时器
- (void)destroyTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)orientChange:(NSNotification *)notification{
    if (_autoFullScreen == NO){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft){
        if (_isFullScreen == NO){
            [self fullScreenWithDirection:Letf];
        }
    }else if (orientation == UIDeviceOrientationLandscapeRight){
        if (_isFullScreen == NO){
            [self fullScreenWithDirection:Right];
        }
    }else if (orientation == UIDeviceOrientationPortrait){
        if (_isFullScreen == YES){
            [self originalscreen];
        }
    }
}

- (void)fullScreenWithDirection:(Direction)direction{
    //记录播放器父类
    _fatherView = self.superview;
    //记录原始大小
    _customFarme = self.frame;
    _isFullScreen = YES;
    [self setStatusBarHidden:YES];
    //添加到Window上
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    if (_isLandscape == YES){
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }else{
        if (direction == Letf){
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation(M_PI / 2);
            }];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.transform = CGAffineTransformMakeRotation( - M_PI / 2);
            }];
        }
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    self.maskView.fullButton.selected = YES;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 原始大小

- (void)originalscreen{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    
    _isFullScreen = NO;
    [self setStatusBarHidden:NO];
    [UIView animateWithDuration:0.25 animations:^{
        //还原
        self.transform = CGAffineTransformMakeRotation(0);
    }];
    self.frame = _customFarme;
    //还原到原有父类上
    [_fatherView addSubview:self];
    self.maskView.fullButton.selected = NO;
}
#pragma mark - APP活动通知

- (void)appDidEnterBackground:(NSNotification *)note{
    //将要挂起，停止播放
    [self pausePlay];
}
- (void)appDidEnterPlayground:(NSNotification *)note{
    //继续播放
    if (_isUserPlay) {
        [self playVideo];
    }
}

#pragma mark - 根据Cell位置判断是否销毁
- (void)calculateScrollOffset:(UITableView *)tableView cell:(UITableViewCell *)cell{

    NSArray *visableCells = tableView.visibleCells;
    if ([visableCells containsObject:cell]) {
        //在屏幕上
    }else{
        //不在屏幕上
        [self destroyPlayer];
    }
    
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame        = self.bounds;
    self.maskView.frame = self.bounds;
}
#pragma mark - dealloc
- (void)dealloc{
    [self.speedMonitor stopNetworkSpeedMonitor];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkDownloadSpeedNotificationKey object:nil];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
    NSLog(@"播放器被销毁了");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
