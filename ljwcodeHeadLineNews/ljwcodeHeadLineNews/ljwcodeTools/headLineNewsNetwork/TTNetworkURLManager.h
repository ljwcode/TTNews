//
//  TTNetworkURLManager.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTNetworkURLManager : NSObject

+(TTNetworkURLManager *)shareInstance;

+(NSString *)TT_homeNewsTitleURL;

+(NSString *)TT_homeNewsListURL;

+(NSString *)TT_newsDetailRecURL;

+(NSString *)TT_articleContentURL:(NSString *)group_id;

+(NSString *)TT_videoTitlesURL;

+(NSString *)TT_videoListURL;

-(NSString *)parseVideoRealURLWithVideo_id:(NSString *)video_id;

+(NSString *)TT_searchKeywordURL;

+(NSString *)TT_SearchRecommendKeywordURL;

+(NSString *)TT_videoDetailInfoURL;

+(NSString *)TT_TableCommentURL;

+(NSString *)TT_videoRecommendURL;

@end

NS_ASSUME_NONNULL_END
