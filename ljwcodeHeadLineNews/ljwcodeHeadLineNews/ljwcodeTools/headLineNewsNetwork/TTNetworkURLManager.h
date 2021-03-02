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

+(NSString *)homeTitleUrlString;

+(NSString *)homeListUrlString;

+(NSString *)videoTitlesURLString;

+(NSString *)videoListURLString;

-(NSString *)parseVideoRealURLWithVideo_id:(NSString *)video_id;

+(NSString *)TT_searchKeywordURL;

+(NSString *)TT_SearchRecommendKeywordURL;

+(NSString *)videoDetailInfoURL;

+(NSString *)TableCommentURL;

+(NSString *)videoRecommendURL;

@end

NS_ASSUME_NONNULL_END
