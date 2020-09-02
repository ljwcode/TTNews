//
//  homeTitleModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTitleModel.h"

@implementation homeTitleModel

-(instancetype)init{
    if(self = [super init]){
        self.name = @"";
        self.category = @"";
        self.concern_id = @"";
        self.default_add = 0;
        self.flags = 0;
        self.icon_url = @"";
        self.tip_new  = 0;
        self.type = 0;
        self.flags = 0;
    }
    return self;
}

@end
