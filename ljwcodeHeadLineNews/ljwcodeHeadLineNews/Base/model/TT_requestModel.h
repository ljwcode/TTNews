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

+ (NSString *)session_id;

+ (NSString *)list_entrance;

+ (NSString *)ab_feature;

+ (NSString *)caid1;

+ (NSString *)strict;

+(NSString *)ab_group;

+(NSString *)caid2;

+(NSString *)language;

+(NSString *)image;

+(NSString *)list_count;

+(NSString *)count;

+(NSString *)tt_from;

+(NSString *)last_refresh_sub_entrance_interval;

+(NSString *)loc_time;

+(NSString *)refer;

+(NSString *)refresh_reason;

+(NSString *)concern_id;

+(NSString *)st_time;

+(NSString *)session_refresh_idx;

+(NSString *)LBS_status;

+(NSString *)rerank;

+(NSString *)detail;

+(NSString *)min_behot_time;

+(NSString *)loc_mode;

+(NSString *)cp;

@end

NS_ASSUME_NONNULL_END
