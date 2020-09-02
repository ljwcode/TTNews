//
//  videoTitleModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoTitleModel.h"

@implementation videoTitleModel

/*
category = "subv_tt_video_sports";
"category_type" = 0;
flags = 0;
"icon_url" = "";
name = "\U4f53\U80b2";
"tip_new" = 0;
type = 4;
"web_url" = "";
*/

-(instancetype)init{
    if(self = [super init]){
        self.category = @"video";
        self.category_type = 0;
        self.flags = 0;
        self.icon_url = @"";
        self.name = @"";
        self.tip_new = 0;
        self.type = 0;
        self.web_url = @"";
    }
    return self;
}

@end
