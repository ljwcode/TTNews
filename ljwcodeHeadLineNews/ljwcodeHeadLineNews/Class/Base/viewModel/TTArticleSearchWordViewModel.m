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
                    if(responseDic.count > 0){
                        NSArray *array = [responseDic objectForKey:@"suggest_words"];
                        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                        for(int i = 0;i < array.count;i++){
                            TTArticleSearchInboxFourWordsModel *model = [[TTArticleSearchInboxFourWordsModel new]mj_setKeyValues:array[i]];
                            [dataArray addObject:model];
                        }
                        [subscriber sendNext:dataArray];
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

/*
 {
     "call_per_refresh" = 2;
     "homepage_search_suggest" = "\U4f5f\U4e3d\U5a05\U63a2\U73ed\U9648\U601d\U8bda | \U5e7f\U5dde\U68e0\U4e0b\U53d1\U751f\U5730\U9677 | \U5973\U661f\U8c22\U73b2\U73b2\U88ab\U4f20\U75c5\U5371 | \U6d1b\U6749\U77f6\U5c01\U57ce";
     "suggest_words" =     (
                 {
             id = 6622799523339048205;
             or = "qohr:167 qvwgr:13";
             "recommend_reason" = "qrec_hot";
             word = "\U4f5f\U4e3d\U5a05\U63a2\U73ed\U9648\U601d\U8bda";
             "words_type" = 2;
         },
                 {
             id = 6901197940909462797;
             or = "qlhq:43 qv:42 qvwgr:1";
             "recommend_reason" = "";
             word = "\U5e7f\U5dde\U68e0\U4e0b\U53d1\U751f\U5730\U9677";
             "words_type" = "";
         },
                 {
             id = 6901256928422008077;
             or = "qohr:203";
             "recommend_reason" = "";
             word = "\U5973\U661f\U8c22\U73b2\U73b2\U88ab\U4f20\U75c5\U5371";
             "words_type" = "";
         },
                 {
             id = 6786563144102712588;
             or = "qvwgr:215";
             "recommend_reason" = "";
             word = "\U6d1b\U6749\U77f6\U5c01\U57ce";
             "words_type" = "";
         }
     );
 }
 */
