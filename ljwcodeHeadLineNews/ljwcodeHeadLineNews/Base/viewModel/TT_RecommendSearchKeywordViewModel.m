//
//  TT_RecommendSearchKeywordViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_RecommendSearchKeywordViewModel.h"
#import "TT_requestModel.h"
#import "TT_recommendSearchKeywordRequestModel.h"
#import "TT_RecKeywordModel.h"
#import <MJExtension.h>

@implementation TT_RecommendSearchKeywordViewModel

-(instancetype)init{
    if(self = [super init]){
        _recSearchCommend = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                TT_recommendSearchKeywordRequestModel *request = [TT_recommendSearchKeywordRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager TT_SearchRecommendKeywordURL] isPost:NO];
                
                request.caid1 = @"9b2daaee7d9878931768ff8f8e010c81";
                request.version_code = [TT_requestModel version_code];
                request.tma_jssdk_version = [TT_requestModel tma_jssdk_version];
                request.app_name = [TT_requestModel app_name];
                request.app_version = [TT_requestModel app_version];
                request.vid = [TT_requestModel vid];
                request.carrier_region = @"CN";
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
                request.app_id = @"13";
                request.tab_name = @"stream";
                request.query = @"";
                request.penetrate_params = @"%7B%22homepage_search_suggest%22%3A%5B%22%E5%AE%8B%E8%BD%B6%E5%8F%91%E6%96%87%E9%81%93%E6%AD%89%22%2C%22%E4%BC%9F%E5%A4%A7%E7%9A%84%E8%BD%AC%E6%8A%98%E7%94%B5%E8%A7%86%E5%89%A7%22%5D%7D";
                request.search_position = @"search_bar";
                request.category_name = [NSString stringWithFormat:@"__all__"];
                request.business_id = @"10000";
                request.from_group_id = @"0";
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    NSArray *dataArray = [[responseDic objectForKey:@"data"][0] objectForKey:@"words"];
                    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                    if(dataArray.count > 0){
                        for(int i = 0;i <dataArray.count;i++){
                            TT_RecKeywordModel *model = [[[TT_RecKeywordModel alloc]init]mj_setKeyValues:dataArray[i]];
                            [modelArray addObject:model.word];
                        }
                        [subscriber sendNext:modelArray];
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
