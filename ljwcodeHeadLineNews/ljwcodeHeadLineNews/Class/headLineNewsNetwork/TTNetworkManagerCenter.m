//
//  TTNetworkManagerCenter.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTNetworkManagerCenter.h"

@implementation TTNetworkManagerCenter

+(AFHTTPSessionManager *)manager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 16.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    return manager;
}

+(NSURLSessionDataTask *)PostRequestWithUrlString:(NSString *)urlString paramater:(NSDictionary *)parameter successHandle:(requestSucceedHandle)successHandle failHandle:(requestFailHandle)failHandle{
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [self.manager POST:urlString parameters:parameter headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successHandle){
            successHandle(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failHandle){
            failHandle(error);
        }
    }];
    
}

+(NSURLSessionDataTask *)GetRequestWithUrlString:(NSString *)urlString parameter:(NSDictionary *)parameter successHandle:(requestSucceedHandle)successHandle failHandle:(requestFailHandle)failHandle{
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [self.manager GET:urlString parameters:parameter headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successHandle){
            successHandle(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failHandle){
            failHandle(error);
        }
    }];
}

@end
