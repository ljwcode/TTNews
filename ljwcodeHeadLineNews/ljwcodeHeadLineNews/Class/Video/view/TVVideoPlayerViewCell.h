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
@class TVVideoPlayerViewCell;

@protocol TVVideoPlayerCellDelegate<NSObject>

- (void)initPlayerView:(TVVideoPlayerViewCell *)cell playClick:(videoDetailModel *)convention;

@end

@interface TVVideoPlayerViewCell : UITableViewCell

@property(nonatomic,assign)CGRect videoFrame;

@property(nonatomic,strong)videoContentModel *contentModel;

@property(nonatomic,copy)void(^imgViewCallBack)(UIView *parentView);

@property(nonatomic,assign)id<TVVideoPlayerCellDelegate,NSObject>delegate;

-(void)setDelegate:(id<TVVideoPlayerCellDelegate,NSObject> _Nonnull)delegate withIndexPath:(NSIndexPath *)indexPath;

-(void)setNormalModel;

@end

NS_ASSUME_NONNULL_END
