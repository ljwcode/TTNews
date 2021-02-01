//
//  videoDetailRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTNetworkBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface videoDetailRequestModel : TTNetworkBaseModel

@property(nonatomic,copy)NSString *forum_id;

@property(nonatomic,assign)float group_id;

@property(nonatomic,assign)float count;

@property(nonatomic,assign)float offset;

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *app_name;

@property(nonatomic,copy)NSString *version_code;

@property(nonatomic,copy)NSString *device_platform;

@property(nonatomic,copy)NSString *flags;

@property(nonatomic,copy)NSString *aid;

@property(nonatomic,copy)NSString *aggr_type;

@property(nonatomic,copy)NSString *article_page;

@end

NS_ASSUME_NONNULL_END
