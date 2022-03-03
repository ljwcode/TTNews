//
//  homeNewsMiddleCoverViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsMiddleCoverViewModel.h"
#import <MJExtension/MJExtension.h>

@implementation homeNewsMiddleCoverViewModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"data" : @"homeJokeSummarymodel"
    };
}

@end

@implementation homeJokeSummarymodel

+(NSArray *)mj_ignoredPropertyNames{
    return @[@"starBtnSelected",@"hateBtnSelected",@"collectionSelected"];
}

-(homeJokeInfoModel *)infoModel{
    if(!_infoModel){
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        homeJokeInfoModel *model = [[homeJokeInfoModel alloc]init];
        [model mj_setKeyValues:dic];
        _infoModel = model;
    }
    
    return _infoModel;
}

@end

@implementation homeJokeInfoModel

-(instancetype)init{
    if(self = [super init]){
        _comment_count = 30;
        _star_count = 180;
        _hate_count = 16;
    }
    return self;
}

+(NSArray *)mj_ignoredPropertyNames{
    return @[@"comment_count",@"star_count",@"hate_count"];
}



@end
