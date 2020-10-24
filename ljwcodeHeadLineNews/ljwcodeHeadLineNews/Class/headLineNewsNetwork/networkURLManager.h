//
//  networkURLManager.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface networkURLManager : NSObject

+(networkURLManager *)shareInstance;

+(NSString *)homeTitleUrlString;

+(NSString *)homeListUrlString;

+(NSString *)videoTitlesURLString;

+(NSString *)videoListURLString;

+(NSString *)microHeadlineURLString;

+(NSString *)microVideoURLString;

+(NSString *)playVideoURLString;

-(NSString *)parseVideoRealURLWithVideo_id:(NSString *)video_id;

+(NSString *)searchSuggestionUrl;
@end

NS_ASSUME_NONNULL_END
