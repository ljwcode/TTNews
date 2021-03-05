//
//  homeTitleViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTitleViewModel.h"
#import "homeTitleModel.h"
#import "homeTitleRequestModel.h"
#import "TT_requestModel.h"

@implementation homeTitleViewModel

-(instancetype)init{
    if(self = [super init]){
        _titleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                homeTitleRequestModel *request = [homeTitleRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.TT_homeNewsTitleURL isPost:NO];
       
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
                [request sendRequestWithSuccess:^(id response) {
                    
                    NSDictionary *responseDic = (NSDictionary *)response;
                    responseDic = responseDic[@"data"];
                    NSMutableArray *models = [NSMutableArray array];
                    if (responseDic.count > 0) {
                        NSArray *dicArr = [[NSArray alloc]init];
                        dicArr = responseDic[@"data"];
                        for (int i = 0; i < [dicArr count]; i++) {
                            homeTitleModel *model = [[homeTitleModel new] mj_setKeyValues:dicArr[i]];
                            [models addObject:model];
                        }
                        [subscriber sendNext:models];
                        [subscriber sendCompleted];
                        
                    }else {
                        [MBProgressHUD showError: @"网络异常" toView:nil];
                    }
                } failHandle:^(NSError *error) {
                    [MBProgressHUD showSuccess:@"网络请求失败"];
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
