//
//  newsDetailHeaderViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/6.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "newsDetailHeaderViewModel.h"
#import "newsDetailModel.h"
#import "homeNewsRequestModel.h"

@interface newsDetailHeaderViewModel()

@end

@implementation newsDetailHeaderViewModel

-(instancetype)init{
    if(self = [super init]){
        _newsHeaderCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                homeNewsRequestModel *request = [homeNewsRequestModel initWithNetworkModelWithUrlString:networkManager.homeListUrlString isPost:NO];
                request.category = input;
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.device_platform = @"iphone 11 Pro";
                request.version_code = @"7.7.0";
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    newsDetailModel *model = [[newsDetailModel alloc]init];
                    [model mj_setKeyValues:responseDic];
                    [model.dataArray makeObjectsPerformSelector:@selector(infoModel)];
                    [subscriber sendNext:model];
                    [subscriber sendCompleted];
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"request fail");
                }];
                return nil;
            }];
        }];
        
    }
    return self;
}



@end
