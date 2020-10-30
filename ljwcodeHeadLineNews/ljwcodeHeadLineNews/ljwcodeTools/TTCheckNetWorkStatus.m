//
//  TTCheckNetWorkStatus.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTCheckNetWorkStatus.h"
#import <AFNetworkReachabilityManager.h>

@implementation TTCheckNetWorkStatus

+(TTCheckNetWorkStatus *)shareInstance{
    static dispatch_once_t onceToken;
    static TTCheckNetWorkStatus *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[TTCheckNetWorkStatus alloc]init];
    });
    return instance;
}

-(NSString *)currentNetworkStatus{
    __block NSString *networkStatus = nil;
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch(status){
                
            case AFNetworkReachabilityStatusUnknown:
                networkStatus = @"未知网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus = @"无网络连接";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus = @"蜂窝网络";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus = @"WI-FI";
                break;
        }
    }];
    return networkStatus;
}

@end
