//
//  homeMicroVideoRequestViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "homeMicroVideoRequestViewModel.h"
#import "homeNewsRequestModel.h"
#import "homeNewsModel.h"
#import "homeNewsMiddleCoverViewModel.h"
#import "videoContentModel.h"
#import "TT_requestModel.h"

@implementation homeMicroVideoRequestViewModel

- (instancetype)init {
    if(self = [super init]) {
        _microVideoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                homeNewsRequestModel *request = [homeNewsRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.TT_homeNewsListURL isPost:NO];
                /*
                 ?device_id=157930857702792&session_id=9D19C3FC-DDA3-46DA-92AA-C8DFB5A80A5C&list_entrance=more_shortvideo&os_version=12.4.8&ab_feature=2985775,794526,1662483&caid1=626b60a145e6a3340054b5c6d73c1910&strict=0&category=hotsoon_video_feed_card&iid=2190651786797647&app_name=news_article&ab_version=662099,3054932,668775,3054984,3083286,3116939,660830,3054982,3100788,1859936,668779,3054979,668774,2958008,3054973,662176,3054966,3107529&last_refresh_sub_entrance_interval=1630490772&ac=WIFI&detail=1&cp=6f1529Ff52095q1&refer=1&st_time=336&ssmix=a&version_code=8.4.0&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&loc_mode=1&channel=App%20Store&image=1&tma_jssdk_version=2.14.0.6&caid2=&count=20&ab_group=2985775,794526,1662483&update_version_code=84020&tt_from=card_draw&idfa=40DCDF8B-488D-4780-A4D6-DCC51DEA861D&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_platform=iphone&device_type=iPhone%206&rerank=0&ad_ui_style=%7B%22van_package%22%3A130000060%2C%22is_crowd_generalization_style%22%3A2%7D&ab_client=a1,f2,f7,e1&LBS_status=authroize&loc_time=1630490702&aid=13&language=zh-Hans-CN&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&app_version=8.4.0&resolution=750*1334&min_behot_time=0
                 */
                request.device_id = [TT_requestModel device_id];
                request.session_id = [TT_requestModel session_id];
                request.list_entrance = [TT_requestModel list_entrance];
                request.ab_feature = [TT_requestModel ab_feature];
                request.caid1 = [TT_requestModel caid1];
                request.strict = [TT_requestModel strict];
                request.category = @"hotsoon_video_feed_card";
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
                
                [request sendRequestWithSuccess:^(id  _Nonnull response) {
                    NSDictionary *responseDic = (NSDictionary *)response;
                } failHandle:^(NSError * _Nonnull error) {
                    
                }];
                
                return  nil;
            }];
        }];
    }
    return  self;
}

@end
