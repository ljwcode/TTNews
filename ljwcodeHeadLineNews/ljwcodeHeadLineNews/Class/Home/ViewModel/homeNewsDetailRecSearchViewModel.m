//
//  homeNewsDetailRecSearchViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "homeNewsDetailRecSearchViewModel.h"
#import "TT_requestModel.h"
#import <MJExtension/MJExtension.h>
#import "homeNewsDetailRecSearchRequestModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation homeNewsDetailRecSearchViewModel

-(instancetype)init{
    if(self = [super init]){
        _recSearchCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                NSDictionary *dict = @{
                    @"group_id" : input,
                    @"item_id"  : input,
                    @"caid1" : @"626b60a145e6a3340054b5c6d73c1910"
                    
                };
                [manager GET:[TTNetworkURLManager TT_newsDetailRecURL] parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *responseDic = (NSDictionary *)responseObject;
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
