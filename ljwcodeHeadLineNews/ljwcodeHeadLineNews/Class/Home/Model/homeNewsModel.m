//
//  homeNewsModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsModel.h"
#import <MJExtension/MJExtension.h>

@implementation homeNewsModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"data" : @"homeNewsSummaryModel"
    };
}

@end

@implementation homeNewsImageModel

@end

@implementation homeNewsInfoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"image_list" : @"homeNewsImageModel"
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


