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
    return @"https://api5-normal-c-lq.snssdk.com/article/category/get_subscribed/v4/?";
}

+(NSString *)homeListUrlString{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v88/?"];
}

+ (NSString *)videoTitlesURLString {
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/video_api/get_category/v3/?"];
}
+ (NSString *)videoListURLString {
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v64/?"];
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
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/video/app/article/information/v25/?"];
}

+(NSString *)videoRecommendURL{
    return [NSString stringWithFormat:@"https://api5-normal-c-lq.snssdk.com/api/news/feed/v64/?"];
}

+(NSString *)TableCommentURL{
    return [NSString stringWithFormat:@"https://api3-normal-c-lq.snssdk.com/article/v4/tab_comments/?"];
}

@end
