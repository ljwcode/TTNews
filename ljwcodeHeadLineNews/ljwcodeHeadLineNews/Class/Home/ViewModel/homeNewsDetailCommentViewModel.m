//
//  homeNewsDetailCommentViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/9.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "homeNewsDetailCommentViewModel.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import "TTNetworkURLManager.h"
#import "TT_UserCommentModel.h"

@implementation homeNewsDetailCommentViewModel

-(instancetype)init{
    if(self = [super init]){
        _newsDetailCommend = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
                NSDictionary *dict = @{
                    @"group_id" : input,
                    @"caid1" : @"626b60a145e6a3340054b5c6d73c1910"
                };
                [manager POST:[TTNetworkURLManager TT_TableCommentURL] parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *responseDic = (NSDictionary *)responseObject;
                    NSArray *dataArray = [responseDic objectForKey:@"data"];
                    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                    for(int i = 0;i < dataArray.count;i++){
                        TT_UserCommentModel *model = [[[TT_UserCommentModel alloc]init]mj_setKeyValues:dataArray[i]];
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
