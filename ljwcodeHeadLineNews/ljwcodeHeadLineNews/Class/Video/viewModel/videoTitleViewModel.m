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
#import "ljwcodeHeader.h"
#import <MJExtension.h>


@implementation videoTitleViewModel

-(instancetype)init{
    if(self = [super init]){
        
        _videoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                videoTitleRequestModel *request = [videoTitleRequestModel initWithNetworkModelWithUrlString:networkManager.videoTitlesURLString isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.device_platform = @"iPhone 11 Pro";
                request.version_code = @"7.7.0";
                request.input = input;
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    responseDic = [responseDic objectForKey:@"data"];
                    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                    if(responseDic.count > 0){
                        NSArray *responseArray = (NSArray*) responseDic;
                        for(int i = 0;i < responseArray.count;i++){
                            videoTitleModel *titleModel = [[videoTitleModel new]mj_setKeyValues:responseArray[i]];
                            [modelArray addObject:titleModel];
                        }
                        [subscriber sendNext:modelArray];
                        [subscriber sendCompleted];
                    }
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"request video title fail");
                }];
                
                return nil;
            }];
        }];

    }
    
    return self;
}


@end
