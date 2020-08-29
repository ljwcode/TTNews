//
//  TTSearchSuggestionViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTSearchSuggestionViewModel.h"
#import "TTSearchSuggestionRequestModel.h"
#import <MJExtension/MJExtension.h>
#import "TTHeader.h"
#import "networkURLManager.h"
#import "networkBaseModel.h"

@interface TTSearchSuggestionViewModel()

@end

@implementation TTSearchSuggestionViewModel

-(instancetype)init{
    if(self = [super init]){
        _SearchSuggestionCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSubject createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                TTSearchSuggestionRequestModel *request = [TTSearchSuggestionRequestModel initWithNetworkModelWithUrlString:networkURLManager.searchSuggestionUrl isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = [(NSDictionary *)response objectForKey:@"data"];
                    NSString *title = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"homepage_search_suggest"]];
                    [subscriber sendNext:title];
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
