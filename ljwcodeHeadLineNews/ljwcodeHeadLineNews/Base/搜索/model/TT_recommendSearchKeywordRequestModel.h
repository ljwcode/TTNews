//
//  TT_recommendSearchKeywordRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTNetworkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TT_recommendSearchKeywordRequestModel : TTNetworkBaseModel

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

@property(nonatomic,copy)NSString *app_id;

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *device_type;

@property(nonatomic,copy)NSString *ab_client;

@property(nonatomic,copy)NSString *idfa;

@property(nonatomic,copy)NSString *tab_name;

@property(nonatomic,copy)NSString *query;

@property(nonatomic,copy)NSString *penetrate_params;

@property(nonatomic,copy)NSString *search_position;

@property(nonatomic,copy)NSString *category_name;

@property(nonatomic,copy)NSString *business_id;

@property(nonatomic,copy)NSString *from_group_id;

@end

NS_ASSUME_NONNULL_END
