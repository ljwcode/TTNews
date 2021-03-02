//
//  TTSearchSuggestionRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTNetworkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSearchSuggestionRequestModel : TTNetworkBaseModel

@property(nonatomic,copy)NSString *caid1;

@property(nonatomic,copy)NSString *carrier_region;

@property(nonatomic,copy)NSString *version_code;

@property(nonatomic,copy)NSString *tma_jssdk_version;

@property(nonatomic,copy)NSString *app_name;

@property(nonatomic,copy)NSString *app_version;

@property(nonatomic,copy)NSString *vid;

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,copy)NSString *channel;

@property(nonatomic,copy)NSString *resolution;

@property(nonatomic,copy)NSString  *aid;

@property(nonatomic,copy)NSString *update_version_code;

@property(nonatomic,copy)NSString *cdid;

@property(nonatomic,copy)NSString *idfv;

@property(nonatomic,copy)NSString *ac;

@property(nonatomic,copy)NSString *os_version;

@property(nonatomic,copy)NSString *ssmix;

@property(nonatomic,copy)NSString *device_platform;

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *device_type;

@property(nonatomic,copy)NSString *ab_client;

@property(nonatomic,copy)NSString *idfa;


@end

NS_ASSUME_NONNULL_END
