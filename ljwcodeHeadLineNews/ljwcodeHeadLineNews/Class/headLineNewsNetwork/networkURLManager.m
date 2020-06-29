//
//  networkManager.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "networkManager.h"
#import "ljwcodeHeader.h"

@implementation networkManager

+(NSString *)homeTitleUrlString{
    return [NSString stringWithFormat:@"%@article/category/get_subscribed/v1/?",ljwcode_Base_url];
}

@end
