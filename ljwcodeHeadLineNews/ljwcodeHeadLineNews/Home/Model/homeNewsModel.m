//
//  homeNewsModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsModel.h"
#import <MJExtension/MJExtension.h>

@implementation microToutiaoUserInfo


@end

@implementation detail_cover_list



@end

@implementation dataArray


@end

@implementation large_image_list



@end

@implementation filter_words



@end

@implementation url_list



@end

@implementation animated_cover_image_list



@end

@implementation raw_data



@end

@implementation homeNewsModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"data" : @"homeNewsSummaryModel"
    };
}

@end

@implementation homeNewsImageModel

@end

@implementation tips


@end

@implementation microVideoInfoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"data" : @"shortVideoArray"
    };
}

@end

@implementation microVideoDetailModel

-(microVideoInfoModel *)microInfoModel{
    if(!_microInfoModel){
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        microVideoInfoModel *model = [[microVideoInfoModel alloc]init];
        [model mj_setKeyValues:dic];
        _microInfoModel = model;
    }
    return _microInfoModel;
}

@end

@implementation homeNewsMicroVideoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"data" : @"microVideoDetailModel"
    };
}


@end

@implementation homeNewsInfoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"image_list" : @"homeNewsImageModel",
        @"detail_cover_list" : @"detail_cover_list",
        @"action_list" : @"action_lsit"
    };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return  @{
        @"microToutiaoUserID" : @"id"
    };
}

@end

@implementation homeNewsSummaryModel

-(homeNewsInfoModel *)infoModel{
    if(!_infoModel){
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        homeNewsInfoModel *model = [[homeNewsInfoModel alloc]init];
        [model mj_setKeyValues:dic];
        _infoModel = model;
    }
    return _infoModel;
}

@end


