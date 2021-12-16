//
//  TTArticleSearchWordViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/2.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchWordViewModel.h"
#import "TTArticleSearchInboxFourWordsModel.h"
#import "TTSearchSuggestionRequestModel.h"
#import "TTNetworkURLManager.h"
#import "TT_requestModel.h"

@interface TTArticleSearchWordViewModel()


@end

@implementation TTArticleSearchWordViewModel

-(instancetype)init{
    if(self = [super init]){
        _searchWordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                TTSearchSuggestionRequestModel *request = [TTSearchSuggestionRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager TT_searchKeywordURL] isPost:NO];
                
                request.caid1 = @"";
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
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = [(NSDictionary *)response objectForKey:@"data"];
                    if(responseDic.count > 0){
                        NSArray *array = [responseDic objectForKey:@"suggest_words"];
                        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                        for(int i = 0;i < array.count;i++){
                            TTArticleSearchInboxFourWordsModel *model = [[TTArticleSearchInboxFourWordsModel new]mj_setKeyValues:array[i]];
                            [dataArray addObject:model.word];
                        }
                        [subscriber sendNext:dataArray];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"recommandSearchWords"];
                        [subscriber sendCompleted];
                        
                    }
                    
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"search title request error");
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
