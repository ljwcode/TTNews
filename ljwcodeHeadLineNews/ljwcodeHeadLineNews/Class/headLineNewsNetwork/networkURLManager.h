//
//  networkURLManager.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface networkManager : NSObject

+(NSString *)homeTitleUrlString;

+(NSString *)homeListUrlString;

+(NSString *)videoTitlesURLString;

+(NSString *)videoListURLString;

+(NSString *)microHeadlineURLString;

+(NSString *)microVideoURLString;

+(NSString *)playVideoURLString;

@end

NS_ASSUME_NONNULL_END
