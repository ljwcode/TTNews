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

@interface TTArticleSearchWordViewModel()


@end

@implementation TTArticleSearchWordViewModel

-(instancetype)init{
    if(self = [super init]){
        _searchWordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                TTSearchSuggestionRequestModel *request = [TTSearchSuggestionRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.searchSuggestionUrl isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = [(NSDictionary *)response objectForKey:@"data"];
                    NSMutableArray *wordArray = [NSMutableArray array];
                    if(responseDic.count > 0){
                        
                        NSArray *array = [responseDic objectForKey:@"suggest_words"];
                        for(int i = 0;i < array.count;i++){
                            TTArticleSearchInboxFourWordsModel *model = [[TTArticleSearchInboxFourWordsModel new]mj_setKeyValues:array[i]];
                            [wordArray addObject:model];
                        }
                    }
                    [subscriber sendNext:wordArray];
                    [subscriber sendCompleted];
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
