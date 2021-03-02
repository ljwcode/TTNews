//
//  TT_requestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TT_requestModel : NSObject


+(NSString *)version_code;

+(NSString *)tma_jssdk_version;

+(NSString *)app_name;

+(NSString *)app_version;

+(NSString *)vid;

+(NSString *)device_id;

+(NSString *)channel;

+(NSString *)resolution;

+(NSString *)aid;

+(NSString *)update_version_code;

+(NSString *)cdid;

+(NSString *)idfv;

+(NSString *)ac;

+(NSString *)os_version;

+(NSString *)ssmix;

+(NSString *)device_platform;

+(NSString *)iid;

+(NSString *)device_type;

+(NSString *)ab_client;

+(NSString *)idfa;

@end

NS_ASSUME_NONNULL_END
