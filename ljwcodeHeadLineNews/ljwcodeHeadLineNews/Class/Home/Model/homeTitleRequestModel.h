//
//  homeTitleRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "networkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface homeTitleRequestModel : networkBaseModel

@property(nonatomic,copy)NSString *iid;

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,assign)int aid;

@end

NS_ASSUME_NONNULL_END
