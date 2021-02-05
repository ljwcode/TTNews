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
#import "TT_requestModel.h"

@implementation videoDetailViewModel

+(void)TT_videoUserDetailNormalComment:(NSString *)group_id{
    videoDetailRequestModel *request = [videoDetailRequestModel initWithNetworkModelWithUrlString:[TTNetworkURLManager videoDetailInfoURL] isPost:NO];
    /*
     https://api3-normal-c-lq.snssdk.com/video/app/article/information/v25/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-000000000000&from=click_video&article_page=1&group_id=6924996500489830919
     */
    request.version_code = [TT_requestModel version_code];
    request.tma_jssdk_version = [TT_requestModel tma_jssdk_version];
    request.app_name = [TT_requestModel app_name];
    request.app_version = [TT_requestModel app_version];
    request.vid = [TT_requestModel vid];
    request.device_id = [TT_requestModel device_id];
    request.channel = [TT_requestModel channel];
    request.resolution = [TT_requestModel resolution];
    request.aid = [TT_requestModel aid];
    request.update_version_code = [TT_requestModel update_version_code];
    request.cdid = [TT_requestModel cdid];
    request.idfv = [TT_requestModel idfv];
    request.ac = [TT_requestModel ac];
    request.os_version = [TT_requestModel os_version];
    request.ssmix = [TT_requestModel ssmix];
    request.device_platform = [TT_requestModel device_platform];
    request.iid = [TT_requestModel iid];
    request.device_type = [TT_requestModel device_type];
    request.ab_client = [TT_requestModel ab_client];
    request.idfa = [TT_requestModel idfa];
    request.from = @"click_video";
    request.article_page = 1;
    request.group_id = group_id;
    [request sendRequestWithSuccess:^(id  _Nonnull response) {
        NSDictionary *responseDic = (NSDictionary *)response;
        NSLog(@"连接成功 = %@",responseDic);
    } failHandle:^(NSError * _Nonnull error) {
        NSLog(@"连接失败");
    }];
}

@end
