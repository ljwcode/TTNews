//
//  networkManagerCenter.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^requestSucceedHandle)(id response);
typedef void(^requestFailHandle)(NSError *error);

@interface networkManagerCenter : NSObject

+(NSURLSessionDataTask *)PostRequestWithUrlString:(NSString *)urlString paramater:(NSDictionary *)parameter successHandle:(requestSucceedHandle)successHandle failHandle:(requestFailHandle)failHandle;

+(NSURLSessionDataTask *)GetRequestWithUrlString:(NSString *)urlString parameter:(NSDictionary *)parameter successHandle:(requestSucceedHandle)successHandle failHandle:(requestFailHandle)failHandle;

@end

NS_ASSUME_NONNULL_END
