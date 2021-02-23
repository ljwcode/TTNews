//
//  XGVideoCommentViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/23.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "XGVideoCommentViewModel.h"
#import <MJExtension/MJExtension.h>
#import "videoDetailRequestModel.h"
#import "TT_requestModel.h"
#import <AFNetworking.h>
#import "TT_VideoCommentModel.h"

@implementation XGVideoCommentViewModel

-(instancetype)init{
    if(self = [super init]){
        _ComRacCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                NSDictionary *dict = @{
                    @"group_id" : input,
                    @"caid1" : @"626b60a145e6a3340054b5c6d73c1910"
                };
                [manager POST:[TTNetworkURLManager TableCommentURL] parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *responseDic = (NSDictionary *)responseObject;
                    NSArray *dataArray = [responseDic objectForKey:@"data"];
                    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                    for(int i = 0;i < dataArray.count;i++){
                        TT_VideoCommentModel *model = [[[TT_VideoCommentModel alloc]init]mj_setKeyValues:dataArray[i]];
                        [modelArray addObject:model];
                    }
                    [subscriber sendNext:modelArray];
                    [subscriber sendCompleted];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
