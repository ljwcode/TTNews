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

@property(nonatomic,strong)videoContentModel *contentModel;

@property(nonatomic,copy)void(^imgViewCallBack)(UIView *parentView);

@end

NS_ASSUME_NONNULL_END
