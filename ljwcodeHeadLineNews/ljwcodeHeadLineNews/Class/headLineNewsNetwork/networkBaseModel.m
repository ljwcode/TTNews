//
//  networkBaseModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "networkBaseModel.h"
#import <MJExtension/MJExtension.h>
#import "MBProgressHUD+Add.h"

#define request_timeOut_code -1001
#define request_network_disconnection_code -1009

@implementation networkBaseModel

-(instancetype)init{
    if(self = [super init]){
        _isPost = YES;
        _showErrorHud = YES;
    }
    return self;
}

+(instancetype)initWithNetworkModelWithUrlString:(NSString *)urlString isPost:(BOOL)isPost
{
    networkBaseModel *model = [[networkBaseModel alloc]init];
    model.isPost = isPost;
    model.urlString = urlString;
    return model;
}

-(void)sendRequestWithSuccess:(requestSucceedHandle)successHandle failHandle:(requestFailHandle)failHandle{
    if(self.urlString.length == 0 || !_urlString){
        return;
    }
    NSMutableDictionary *parameter = [self params];
    if(_isPost){
        [networkManagerCenter PostRequestWithUrlString:_urlString paramater:parameter successHandle:^(id  _Nonnull response) {
            if(successHandle){
                successHandle(response);
            }
        } failHandle:^(NSError * _Nonnull error) {
            if(_showErrorHud){
                [self showNetwordErrorHub:error];
            }
            if(failHandle){
                failHandle(error);
            }
        }];
    }else{
        [networkManagerCenter GetRequestWithUrlString:_urlString parameter:parameter successHandle:^(id  _Nonnull response) {
            if(successHandle){
                successHandle(response);
            }
        } failHandle:^(NSError * _Nonnull error) {
            if(_showErrorHud){
                [self showNetwordErrorHub:error];
            }
            if(failHandle){
                failHandle(error);
            }
        }];
    }
    
}

- (NSMutableDictionary *)params {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params addEntriesFromDictionary:self.parameter];
    [params addEntriesFromDictionary:self.mj_keyValues];
    
    if ([params.allKeys containsObject:@"isPost"]) {
        [params removeObjectForKey:@"isPost"];
    }
    if ([params.allKeys containsObject:@"urlString"]) {
        [params removeObjectForKey:@"urlString"];
    }
    if ([params.allKeys containsObject:@"showErrorHud"]) {
        [params removeObjectForKey:@"showErrorHud"];
    }
    if ([params.allKeys containsObject:@"parameter"]) {
        [params removeObjectForKey:@"parameter"];
    }
    for (id key in params.allKeys) {
        id obj = [params objectForKey:key];
        if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
            [params removeObjectForKey:key];
        }
    }
    return params;
}

-(void)showNetwordErrorHub:(NSError *)error{
    if(error.code == request_timeOut_code){
        [MBProgressHUD showError:@"请求超时" toView:nil];
    }else if(error.code == request_network_disconnection_code){
        [MBProgressHUD showError:@"无法连接网络" toView:nil];
    }else{
        NSString *errMsg = [NSString stringWithFormat:@"请求数据错误%ld",(long)error.code];
        [MBProgressHUD showError:errMsg toView:nil];
    }
}



@end
