//
//  homeNewsCellViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsCellViewModel.h"
#import "homeNewsRequestModel.h"
#import "homeNewsModel.h"
#import "homeJokeModel.h"

@implementation homeNewsCellViewModel

-(instancetype)init{
    
    if(self = [super init]){
        
        _newsCellViewCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                homeNewsRequestModel *request = [homeNewsRequestModel initWithNetworkModelWithUrlString:networkManager.homeListUrlString isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.device_platform = @"iphone 11 Pro";
                request.version_code = @"7.7.0";
                request.category = input;
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    
                    NSDictionary *responseDic = (NSDictionary *)response;
                    
                    if([input isEqualToString:@"essay_joke"]){
                        homeJokeModel *jokeModel = [[homeJokeModel alloc]init];
                        [jokeModel mj_setKeyValues:responseDic];
                        [jokeModel.data_array makeObjectsPerformSelector:@selector(infoModel)];
                        [subscriber sendNext:jokeModel];
                        [subscriber sendCompleted];
                    }else{
                        homeNewsModel *newsModel = [[homeNewsModel alloc]init];
                        [newsModel mj_setKeyValues:responseDic];
                        [newsModel.data makeObjectsPerformSelector:@selector(infoModel)];
                        [subscriber sendNext:newsModel];
                        [subscriber sendCompleted];
                    }
                } failHandle:^(NSError * _Nonnull error) {
                    
                }];
                
                return nil;
            }];
        }];
    }
    return self;
}

@end
