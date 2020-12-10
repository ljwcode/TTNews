//
//  VideoPlayerContainerView.h
//  videoPlayerDemo
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerContainerView : UIView

@property(nonatomic, copy)NSString  *urlVideo;

-(void)dealloc;

@end

NS_ASSUME_NONNULL_END
