//
//  XGVideoDetailRecommendViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "XGVideoDetailRecommendViewModel.h"
#import <MJExtension/MJExtension.h>
#import "videoDetailRequestModel.h"
#import "TT_requestModel.h"
#import "videoContentModel.h"
#import "MBProgressHUD+Add.h"

@implementation XGVideoDetailRecommendViewModel

-(instancetype)init{
    if(self = [super init]){
        _videoRecCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                videoDetailRequestModel *request = [videoDetailRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager videoRecommendURL] isPost:NO];
                
                request.caid1 = @"626b60a145e6a3340054b5c6d73c1910";
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
                    NSArray *dataArray  = responseDic[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for(int i = 0;i < dataArray.count;i++){
                        videoContentModel *model = [[[videoContentModel alloc]init]mj_setKeyValues:dataArray[i]];
                        [array addObject:model];
                    }
                    [subscriber sendNext:array];
                    [subscriber sendCompleted];
                } failHandle:^(NSError * _Nonnull error) {
                    [MBProgressHUD showSuccess:@"请求失败"];
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
