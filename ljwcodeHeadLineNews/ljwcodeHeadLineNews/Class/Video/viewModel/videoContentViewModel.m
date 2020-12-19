//
//  videoContentViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoContentViewModel.h"
#import "TTHeader.h"
#import "videoContentRequestModel.h"
#import <MJExtension.h>
#import "videoContentModel.h"

@implementation videoContentViewModel

-(instancetype)init{
    if(self = [super init]){
        _videoContentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                videoContentRequestModel *request = [videoContentRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.videoListURLString isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.device_platform = @"iPhone 11 Pro";
                request.version_code = @"7.7.0";
                request.category = input;
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    NSArray *dataArray  = responseDic[@"data"];
                    NSMutableArray *array = [NSMutableArray array];
                    for(int i = 0;i < dataArray.count;i++){
                        videoDetailModel *model = [[[videoDetailModel alloc]init]mj_setKeyValues:[dataArray[i] objectForKey:@"content"]];
                        [array addObject:model];
                    }
                    [subscriber sendNext:array];
                    [subscriber sendCompleted];
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"请求失败");
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
