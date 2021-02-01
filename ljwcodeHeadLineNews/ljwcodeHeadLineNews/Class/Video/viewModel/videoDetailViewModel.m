//
//  videoDetailViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "videoDetailViewModel.h"
#import "TTNetworkURLManager.h"
#import "videoDetailRequestModel.h"

@implementation videoDetailViewModel

-(instancetype)init{
    if(self = [super init]){
        _videoDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                videoDetailRequestModel *request = [videoDetailRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager videoDetailURL] isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.forum_id = @"";
                
//                request.aggr_type = @"1";
//                request.aid = @"13";
//                request.app_name = @"今日头条";
//                request.article_page = @"1";
//                request.device_platform = @"iPhone 11 Pro";
//                request.flags = @"0";
//                request.version_code = @"8.0.8";
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                    NSLog(@"连接成功 = %@",responseDic);
                } failHandle:^(NSError * _Nonnull error) {
                    NSLog(@"连接失败");
                }];
                return nil;
            }];
        }];
    }
    return self;
}

+(void)TT_videoUserDetailNormalComment:(float)group_id withCount:(float)count withoffset:(float)offset{
    videoDetailRequestModel *request = [videoDetailRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager videoDetailURL] isPost:YES];
    
    request.group_id = group_id;
    request.forum_id = @"";
    request.count = count;
    request.offset = offset;
    request.device_id = LJWCODE_DEVICE_ID;
    request.iid = LJWCODE_IID;
    
    [request sendRequestWithSuccess:^(id  _Nonnull response) {
        NSDictionary *responseDic = (NSDictionary *)response;
        NSLog(@"连接成功 = %@",responseDic);
    } failHandle:^(NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}

@end
