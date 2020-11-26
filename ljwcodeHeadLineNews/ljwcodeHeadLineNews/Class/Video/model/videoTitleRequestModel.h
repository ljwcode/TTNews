//
//  videoTitleRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTNetworkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface videoTitleRequestModel : TTNetworkBaseModel

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *device_platform;

@property(nonatomic,copy)NSString *version_code;

@property(nonatomic,copy)NSString *input;

@end

NS_ASSUME_NONNULL_END
