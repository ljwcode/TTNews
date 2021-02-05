//
//  TTNetworkURLManager.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTNetworkURLManager.h"
#import "TTHeader.h"
#import "NSData+CRC32.h"

@implementation TTNetworkURLManager

+(TTNetworkURLManager *)shareInstance{
    static TTNetworkURLManager *Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[TTNetworkURLManager alloc]init];
    });
    return Instance;
}

+(NSString *)homeTitleUrlString{
    /*
     https://api5-normal-c-lq.snssdk.com/article/category/get_subscribed/v4/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-0000000000000
     */
//    return [NSString stringWithFormat:@"%@article/category/get_subscribed/v1/?",ljwcode_Base_url];
    return @"https://api5-normal-c-lq.snssdk.com/article/category/get_subscribed/v4/?";
}

+(NSString *)homeListUrlString{
    /*
     https://api5-normal-c-lq.snssdk.com/api/news/feed/v88/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&ab_version=660830,2419363,2424988,662176,2424972,1859936,662099,2424937,2416735,2384583,668774,2424979,1593455,2001175,2247462,2424274,668775,2424990,668779,2424985,1877264,2426893&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-000000000000
     */
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v88/?"];
}

+ (NSString *)videoTitlesURLString {
    /*
     https://api5-normal-c-lq.snssdk.com/video_api/get_category/v3/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-000000000000
     */
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/video_api/get_category/v3/?"];
}
+ (NSString *)videoListURLString {
    /*
     https://api3-normal-c-lq.snssdk.com/api/news/feed/v64/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-000000000000
     */
    return [NSString stringWithFormat:@"https://api3-normal-c-lq.snssdk.com/api/news/feed/v64/?"];
}

+ (NSString *)microHeadlineURLString {
    return [NSString stringWithFormat:@"%@api/news/feed/v54/?",ljwcode_Base_url];
}

+ (NSString *)microVideoURLString {
    return [NSString stringWithFormat:@"%@api/news/feed/v75/?",ljwcode_Base_url];
}

-(NSString *)parseVideoRealURLWithVideo_id:(NSString *)video_id{
    int r = arc4random();
    if(r < 0){
        r = abs(r);
    }
    NSString *url = [NSString stringWithFormat:@"/video/urls/v/1/toutiao/mp4/%@?r=%d",video_id,r];
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    UInt64 crc32 = data.getCRC32;
    if(crc32 < 0){
        crc32 += 0x100000000;
    }
    NSString *realURL = [NSString stringWithFormat:@"http://is.snssdk.com/video/urls/v/1/toutiao/mp4/%@?r=%d&s=%llu",video_id,r,crc32];
    return realURL;
}

+(NSString *)searchSuggestionUrl{
    NSString *url = [NSString stringWithFormat:@"%@search/suggest/homepage_suggest/?",ljwcode_Base_url];
    return url;
}

+(NSString *)videoDetailInfoURL{
    /*
     https://api3-normal-c-lq.snssdk.com/video/app/article/information/v25/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-000000000000&from=click_video&article_page=1&group_id=6924996500489830919
     */
    return [NSString stringWithFormat:@"https://api3-normal-c-lq.snssdk.com/video/app/article/information/v25/?"];
}

+(NSString *)TableCommentURL{
    /*
     https://api3-normal-c-lq.snssdk.com/article/v4/tab_comments/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-000000000000&offset=0&category=video&group_id=6919959881197814279
     */
    return [NSString stringWithFormat:@"https://api3-normal-c-lq.snssdk.com/article/v4/tab_comments/?"];
}

@end
