//
//  homeNewsDetailDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/17.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsDetailDBViewModel.h"
#import "homeNewsDetailDBCacheModel.h"
#import <Realm.h>
#import "homeNewsModel.h"
#import "homeJokeModel.h"
#import "videoContentModel.h"
#import <MJExtension.h>

@interface homeNewsDetailDBViewModel()


@end

@implementation homeNewsDetailDBViewModel

-(void)TT_saveHomeNewsDetailModel:(NSArray *)array TT_DetailCategory:(NSString *)category{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
        if([category isEqualToString:@"essay_joke"]){
            for(homeJokeModel *jokeModel in array){
                NSDictionary *dic = [jokeModel mj_keyValues];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
                if(data){
                    NSString *ID = [[NSUUID UUID]UUIDString];
                    [homeNewsDetailDBCacheModel createOrUpdateInRealm:realm withValue:@{@"ID" : ID,@"data" : data}];
                }
            }
        }else if([category isEqualToString:@"video"]){
            for(videoContentModel *videoModel in array){
                NSDictionary *dic = [videoModel mj_keyValues];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
                if(data){
                    NSString *ID = [[NSUUID UUID]UUIDString];
                    [homeNewsDetailDBCacheModel createOrUpdateInRealm:realm withValue:@{@"ID" : ID,@"data" : data}];
                }
            }
        }else{
            for(homeNewsModel *newsModel in array){
                NSDictionary *dic = [newsModel mj_keyValues];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
                if(data){
                    NSString *ID = [[NSUUID UUID]UUIDString];
                    [homeNewsDetailDBCacheModel createOrUpdateInRealm:realm withValue:@{@"ID" : ID,@"data" : data}];
                }
            }
        }
        [realm commitWriteTransaction];
    });
}

-(NSMutableArray *)TT_quertNewsDetailData:(NSString *)category{
    RLMResults *result = [homeNewsDetailDBCacheModel allObjects];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(homeNewsDetailDBCacheModel *model in result){
        NSMutableDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:model.data error:nil];
        if([category isEqualToString:@"essay_joke"]){
            homeJokeModel *jokeModel = [[[homeJokeModel alloc]init]mj_setKeyValues:dic];
            [dataArray addObject:jokeModel];
        }else if([category isEqualToString:@"video"]){
            videoContentModel *videoModel = [[[videoContentModel alloc]init]mj_setKeyValues:dic];
            [dataArray addObject:videoModel];
        }else{
            homeNewsModel *newsModel = [[[homeNewsModel alloc]init]mj_setKeyValues:dic];
            [dataArray addObject:newsModel];
        }
    }
    return dataArray;
}




@end
