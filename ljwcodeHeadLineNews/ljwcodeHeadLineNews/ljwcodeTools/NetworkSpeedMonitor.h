//
//  NetworkSpeedMonitor.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 网速监听工具
 */

extern NSString *const NetworkDownloadSpeedNotificationKey;
extern NSString *const NetworkUploadSpeedNotificationKey;
extern NSString *const NetworkSpeedNotificationKey;

@interface NetworkSpeedMonitor : NSObject

@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;

- (void)startNetworkSpeedMonitor;

- (void)stopNetworkSpeedMonitor;

@end

NS_ASSUME_NONNULL_END
