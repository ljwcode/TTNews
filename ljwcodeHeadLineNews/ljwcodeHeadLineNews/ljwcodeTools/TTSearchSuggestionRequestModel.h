//
//  TTSearchSuggestionRequestModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "networkBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTSearchSuggestionRequestModel : networkBaseModel

@property(nonatomic,copy)NSString *device_id;

@property(nonatomic,copy)NSString *iid;

@end

NS_ASSUME_NONNULL_END
