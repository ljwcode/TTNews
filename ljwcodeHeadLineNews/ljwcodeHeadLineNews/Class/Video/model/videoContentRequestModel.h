//
//  videoContentRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "networkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface videoContentRequestModel : networkBaseModel

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *device_platform;

@property(nonatomic,copy)NSString *version_code;

@property(nonatomic,copy)NSString *input;


//https://is.snssdk.com/video/urls/v/1/toutiao/mp4/9583cca5fceb4c6b9ca749c214fd1f90?r=18723666135963302&s=3807690062&callback=tt_playerzfndr

@property(nonatomic,copy)NSString *r;

@property(nonatomic,copy)NSString *s;

@property(nonatomic,copy)NSString *callback;

@end

NS_ASSUME_NONNULL_END
