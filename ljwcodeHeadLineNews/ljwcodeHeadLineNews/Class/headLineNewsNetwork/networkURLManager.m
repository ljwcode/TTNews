//
//  networkURLManager.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "networkURLManager.h"
#import "ljwcodeHeader.h"

@implementation networkManager

+(NSString *)homeTitleUrlString{
    return [NSString stringWithFormat:@"%@article/category/get_subscribed/v1/?",ljwcode_Base_url];
}

+(NSString *)homeListUrlString{
    return [NSString stringWithFormat:@"%@api/news/feed/v58/?",ljwcode_Base_url];
}

@end
