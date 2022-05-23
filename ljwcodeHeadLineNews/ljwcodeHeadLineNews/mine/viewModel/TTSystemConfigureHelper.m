//
//  TTSystemConfigureHelper.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/5.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTSystemConfigureHelper.h"

@interface TTSystemConfigureHelper()



@end

static TTSystemConfigureHelper *instance = nil;
static dispatch_once_t onceToken;
@implementation TTSystemConfigureHelper

+(TTSystemConfigureHelper *)shareInstance{
    dispatch_once(&onceToken, ^{
        instance = [[TTSystemConfigureHelper alloc]init];
    });
    return instance;
}

-(void)TT_ConfigurePreference{
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle){
        NSLog(@"找不到Settings.bundle文件");
        return;
    }
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences){
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key){
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
