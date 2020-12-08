//
//  parseVideoRealURLViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/9/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "parseVideoRealURLViewModel.h"
#import "videoContentModel.h"
#import "TTNetworkURLManager.h"
#import "TTNetworkManagerCenter.h"
#import "videoRealURLRequestModel.h"
#import <AFNetworking.h>

@implementation parseVideoRealURLViewModel

-(instancetype)init{
    if(self = [super init]){
        _VideoRealURLCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                videoRealURLRequestModel *request = [videoRealURLRequestModel initWithNetworkModelWithUrlString:input isPost:NO];                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    NSDictionary *responseArray = [responseDic objectForKey:@"data"];
                    videoContentModel *model = [[[videoContentModel alloc]init]mj_setKeyValues:responseArray];
                    [subscriber sendNext:model];
                    [subscriber sendCompleted];
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"解析请求失败");
                }];
                return nil;
            }];
            
        }];
    }
    return self;
}

@end
