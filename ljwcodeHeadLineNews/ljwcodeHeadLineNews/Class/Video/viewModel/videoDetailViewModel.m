//
//  videoDetailViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "videoDetailViewModel.h"
#import "TTNetworkURLManager.h"
#import "videoDetailRequestModel.h"
#import "TT_requestModel.h"

@implementation videoDetailViewModel

-(instancetype)init{
    if(self = [super init]){
        _videoDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                videoDetailRequestModel *request = [videoDetailRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager videoDetailInfoURL] isPost:NO];
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
                request.from = @"click_video";
                request.article_page = 1;
                request.group_id = input;
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    NSLog(@"连接成功 = %@",responseDic);
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"连接失败");
                }];
                return nil;
            }];
        }];
    }
    return self;
}
@end
