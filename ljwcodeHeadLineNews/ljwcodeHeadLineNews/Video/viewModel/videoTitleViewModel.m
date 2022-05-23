//
//  videoTitleViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoTitleViewModel.h"
#import "videoTitleRequestModel.h"
#import "videoTitleModel.h"
#import <MJExtension.h>
#import "videoTitleModel.h"
#import "TT_requestModel.h"

@interface videoTitleViewModel()

@end


@implementation videoTitleViewModel

-(instancetype)init{
    if(self = [super init]){
        
        _videoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                videoTitleRequestModel *request = [videoTitleRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.TT_videoTitlesURL isPost:NO];
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
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    NSArray *dicArr = [[NSArray alloc]init];
                    dicArr = responseDic[@"data"];
                    NSMutableArray *modelArray = [NSMutableArray array];
                    if (dicArr.count > 0) {
                        for (int i = 0; i < [dicArr count]; i++) {
                            videoTitleModel *model = [[videoTitleModel new] mj_setKeyValues:dicArr[i]];
                            [modelArray addObject:model];
                        }
                        [subscriber sendNext:modelArray];
                        [subscriber sendCompleted];
                        
                    }else {
                        [MBProgressHUD showError: @"网络异常" toView:nil];
                    }
                } failHandle:^(NSError * _Nonnull error) {
                    [MBProgressHUD showSuccess:@"网络请求失败"];
                    NSLog(@"request video title fail");
                }];
                
                return nil;
            }];
        }];

    }
    
    return self;
}


@end
