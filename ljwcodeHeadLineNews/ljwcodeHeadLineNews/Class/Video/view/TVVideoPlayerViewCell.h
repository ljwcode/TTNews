//
//  TVVideoPlayerViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "videoContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TVVideoPlayerViewCell : UITableViewCell

@property(nonatomic,strong)AVPlayer *player; //播放器

@property(nonatomic,strong)AVPlayerItem *playerItem; //播放单元

@property(nonatomic,strong)AVPlayerLayer *playerLayer;//播放界面

@property(nonatomic,strong)videoContentModel *contentModel;

@end

NS_ASSUME_NONNULL_END
