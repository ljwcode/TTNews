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

/*
 https://api5-normal-c-lq.snssdk.com/article/category/get_subscribed/v4/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-0000000000000
 */

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
