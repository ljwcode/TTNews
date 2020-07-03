//
//  videoContentViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoContentViewModel.h"
#import "ljwcodeHeader.h"
#import "videoContentRequestModel.h"
#import <MJExtension.h>

@implementation videoContentViewModel

-(instancetype)init{
    if(self = [super init]){
        _videoContentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                videoContentRequestModel *request = [[videoContentRequestModel alloc]init];
                request.device_id = LJWCODE_DEVICE_ID;
                request.iid = LJWCODE_IID;
                request.device_platform = @"iPhone 11 Pro";
                request.version_code = @"7.7.0";
                request.input = input;
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    
                    NSDictionary *responseDic = (NSDictionary *)response;
                    
                } failHandle:^(NSError * _Nonnull error) {
                    
                }];
                
                return nil;
            }];
        }];
    }
    return self;
}

@end
