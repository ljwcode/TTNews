//
//  TTCheckNetWorkStatus.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTCheckNetWorkStatus : NSObject

+(TTCheckNetWorkStatus *)shareInstance;

-(NSString *)currentNetworkStatus;

@end

NS_ASSUME_NONNULL_END
