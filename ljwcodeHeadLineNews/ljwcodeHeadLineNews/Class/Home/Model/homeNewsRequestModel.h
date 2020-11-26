//
//  homeNewsRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTNetworkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface homeNewsRequestModel : TTNetworkBaseModel

@property(nonatomic,copy)NSString *category;

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *device_platform;

@property(nonatomic,copy)NSString *version_code;

@end

NS_ASSUME_NONNULL_END
