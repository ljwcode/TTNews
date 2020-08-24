//
//  TTVideoPlayer.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTVideoPlayer : NSObject

/**
 全局播放器单例
 */
+ (TTVideoPlayer *)Player;

/**
 在指定View上 通过url播放视频
 */
- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
