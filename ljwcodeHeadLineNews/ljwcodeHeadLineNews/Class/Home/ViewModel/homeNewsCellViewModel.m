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
#import "videoContentModel.h"
#import "TT_requestModel.h"

@implementation homeNewsCellViewModel

-(instancetype)init{
    
    if(self = [super init]){
        
        _newsCellViewCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                homeNewsRequestModel *request = [homeNewsRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.TT_homeNewsListURL isPost:NO];

                request.version_code = [TT_requestModel version_code];
                request.tma_jssdk_version = [TT_requestModel tma_jssdk_version];
                request.app_name = [TT_requestModel app_name];
                request.app_version = [TT_requestModel app_version];
                request.vid = [TT_requestModel vid];
                request.device_id = [TT_requestModel device_id];
                request.channel = [TT_requestModel channel];
                request.resolution = [TT_requestModel resolution];
                request.aid = [TT_requestModel aid];
                request.update_version_code = [TT_requestModel update_version_code];
                request.cdid = [TT_requestModel cdid];
                request.idfv = [TT_requestModel idfv];
                request.ac = [TT_requestModel ac];
                request.os_version = [TT_requestModel os_version];
                request.ssmix = [TT_requestModel ssmix];
                request.device_platform = [TT_requestModel device_platform];
                request.iid = [TT_requestModel iid];
                request.device_type = [TT_requestModel device_type];
                request.ab_client = [TT_requestModel ab_client];
                request.idfa = [TT_requestModel idfa];
                request.category = input;
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    if([input isEqualToString:@"essay_joke"]){
                        homeJokeModel *jokeModel = [[homeJokeModel alloc]init];
                        [jokeModel mj_setKeyValues:responseDic];
                        [jokeModel.data_array makeObjectsPerformSelector:@selector(infoModel)];
                        [subscriber sendNext:jokeModel];
                        [subscriber sendCompleted];
                    }else if([input isEqualToString:@"video"]){
                        NSArray *modelArray = responseDic[@"data"];
                        NSMutableArray *array = [NSMutableArray array];
                        for(int i = 0;i < modelArray.count;i++){
                            videoContentModel *model = [[[videoContentModel alloc]init]mj_setKeyValues:modelArray[i]];
                            [array addObject:model];
                        }
                        [subscriber sendNext:array]; //发送一个数组
                        [subscriber sendCompleted];
                    }else{
                        homeNewsModel *newsModel = [[homeNewsModel alloc]init];
                        [newsModel mj_setKeyValues:responseDic];
                        [newsModel.data makeObjectsPerformSelector:@selector(infoModel)];
                        [subscriber sendNext:newsModel];
                        [subscriber sendCompleted];
                    }
                } failHandle:^(NSError * _Nonnull error) {
                    [MBProgressHUD showSuccess:@"网络请求失败"];
                }];


                return nil;
            }];
        }];
    }
    return self;
}

@end
