//
//  TTNetworkURLManager.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTNetworkURLManager.h"
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

+(NSString *)TT_homeNewsTitleURL{
    return @"https://api5-normal-c-lq.snssdk.com/article/category/get_subscribed/v4/?";
}

+(NSString *)TT_homeNewsListURL{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v88/?"];
}

+(NSString *)TT_newsDetailRecURL{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/2/article/information/v27/?"];
}

+(NSString *)TT_articleContentURL:(NSString *)group_id{
    return [NSString stringWithFormat:@"https://a3-ipv6.pstatp.com/article/content/25/2/%@/%@/1/0/0/",group_id,group_id];
}

+ (NSString *)TT_videoTitlesURL {
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/video_api/get_category/v3/?"];
}
+ (NSString *)TT_videoListURL {
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v64/?"];
}

///  真实视频URL解析
/// @param video_id 当前视频video_id
-(NSString *)parseVideoRealURLWithVideo_id:(NSString *)video_id{
    int r = arc4random();
    if(r < 0){
        r = abs(r);
    }
    NSString *url = [NSString stringWithFormat:@"/video/urls/v/1/toutiao/mp4/%@?r=%d",video_id,r];
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    UInt64 crc32 = [data getCRC32];
    if(crc32 < 0){
        crc32 += 0x100000000;
    }
    NSString *realURL = [NSString stringWithFormat:@"http://is.snssdk.com/video/urls/v/1/toutiao/mp4/%@?r=%d&s=%llu",video_id,r,crc32];
    return realURL;
}

+(NSString *)TT_searchKeywordURL{    
    NSString *URL = [NSString stringWithFormat:@"https://search3-search-hl.toutiaoapi.com/search/suggest/homepage_suggest/?"];
    
    return URL;
}

+(NSString *)TT_SearchRecommendKeywordURL{
    NSString *URL = [NSString stringWithFormat:@"https://search3-search-lq.toutiaoapi.com/api/suggest_words/?"];
    return URL;
}

+(NSString *)TT_videoDetailInfoURL{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/video/app/article/information/v25/?"];
}

+(NSString *)TT_videoRecommendURL{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v64/?"];
}

+(NSString *)TT_TableCommentURL{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/article/v4/tab_comments/"];
}

+(NSString *)TT_loginQuestionURL{
    return [NSString stringWithFormat:@"https://api5-normal-lq.toutiaoapi.com/passport/user/login/faq/?hide_more&version_code=8.3.3&tma_jssdk_version=1.2.2.0&app_name=news_article&vid=F4347D0F-B827-4892-BA07-503018164CCB&device_id=67277920039&channel=App Store&resolution=828*1792&aid=13&ab_version=1859936,668779,2850858,668774,2850852,662176,2850845,662099,2850811,668775,2716807,2850863,2915144,2928549,660830,2850861,2924769,2841882,2850079,2901207&ab_feature=794526,1662483&ab_group=794526,1662483&update_version_code=83320&openudid=622d86d1a146c15622b6f026364f8b62edfddd61&cdid=2CA3EE9D-F644-4297-9072-3F8AD4550327&idfv=F4347D0F-B827-4892-BA07-503018164CCB&ac=WIFI&os_version=14.6&status_bar_height=44&ssmix=a&device_platform=iphone&tt_font_size=m&iid=4398522541809007&ab_client=a1,f2,f7,e1&device_type=iPhone XR&idfa=00000000-0000-0000-0000-000000000000"];
}

@end

