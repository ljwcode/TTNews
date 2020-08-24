//
//  VideoCoverCollectionViewCell.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "VideoCoverCollectionViewCell.h"
#import "TTScreen.h"
#import "TTVideoToolBar.h"
#import "TTVideoPlayer.h"

@interface VideoCoverCollectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) TTVideoToolBar *toolbar;

@end

@implementation VideoCoverCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - TTToolBarHeight)];
            _coverView;
        })];

        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - UI(50)) / 2, (frame.size.height - TTToolBarHeight - UI(50)) / 2, UI(50), UI(50))];
            _playButton.image = [UIImage imageNamed:@"videoPlay"];
            _playButton;
        })];

        [self addSubview:({
            _toolbar = [[TTVideoToolBar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, TTToolBarHeight)];
            _toolbar;
        })];

        //点击全部Item都支持播放
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - public method

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _videoUrl = videoUrl;
    [_toolbar layoutWithModel:nil];
}

#pragma mark - private method

- (void)_tapToPlay {
    //在当前Item上播放视频
    [[TTVideoPlayer Player] playVideoWithUrl:_videoUrl attachView:_coverView];
}

@end
