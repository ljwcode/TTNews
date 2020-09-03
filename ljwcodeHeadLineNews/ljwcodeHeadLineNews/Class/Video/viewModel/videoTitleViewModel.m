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
#import "TTHeader.h"
#import <MJExtension.h>
#import "videoTitleModel.h"

@interface videoTitleViewModel()

@end


@implementation videoTitleViewModel

-(instancetype)init{
    if(self = [super init]){
        
        _videoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                videoTitleRequestModel *request = [videoTitleRequestModel initWithNetworkModelWithUrlString:networkURLManager.videoTitlesURLString isPost:NO];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.device_platform = @"iPhone 11 Pro";
                request.version_code = @"7.7.0";
                request.input = input;
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    /*
                    category = "subv_tt_video_sports";
                    "category_type" = 0;
                    flags = 0;
                    "icon_url" = "";
                    name = "\U4f53\U80b2";
                    "tip_new" = 0;
                    type = 4;
                    "web_url" = "";
                    */
//                    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"{\"category\": \"video\", \"name\": \"推荐\"}", nil];
//                    NSString *jsonStr = @"{\"category\": \"video\", \"name\": \"推荐\"}";
                    
                    NSDictionary *responseDic = (NSDictionary *)response;
                    responseDic = [responseDic objectForKey:@"data"];
                    
                    NSMutableDictionary *videoDic = [[NSMutableDictionary alloc]init];
                    videoDic[@"category"] = @"video";
                    videoDic[@"category_type"] = @"0";
                    videoDic[@"flags"] = @"0";
                    videoDic[@"icon_url"] = @"";
                    videoDic[@"name"] = @"推荐";
                    videoDic[@"tip_new"] = @"0";
                    videoDic[@"type"] = @"4";
                    videoDic[@"web_url"] = @"";
                    
                    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                    if(responseDic.count > 0){
                        NSMutableArray *responseArray = [NSMutableArray array];
                        responseArray = (NSMutableArray *)responseDic.mutableCopy;
                        [responseArray insertObject:videoDic atIndex:0];
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
