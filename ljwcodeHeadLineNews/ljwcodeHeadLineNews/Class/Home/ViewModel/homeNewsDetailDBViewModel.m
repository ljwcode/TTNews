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
#import "homeNewsMiddleCoverViewModel.h"
#import "videoContentModel.h"
#import <MJExtension.h>

@interface homeNewsDetailDBViewModel()


@end

@implementation homeNewsDetailDBViewModel

-(void)TT_saveHomeNewsDetailModel:(NSArray *)array TT_DetailCategory:(NSString *)category{
    
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dbName = [NSString stringWithFormat:@"TT_NewsDetail_%@.realm",category];
    NSString *filePath = [dbPath stringByAppendingPathComponent:dbName];
    RLMRealmConfiguration *dbConfig = [RLMRealmConfiguration defaultConfiguration];
    dbConfig.fileURL = [NSURL URLWithString:filePath];
    dbConfig.readOnly = NO;
    int currentVersion = 1.0;
    dbConfig.schemaVersion = currentVersion;
    [RLMRealmConfiguration setDefaultConfiguration:dbConfig];
    
    RLMRealm *realm = [RLMRealm realmWithURL:[NSURL URLWithString:filePath]];
    [realm beginWriteTransaction];
    if([category isEqualToString:@"essay_joke"]){
        for(homeNewsMiddleCoverViewModel *jokeModel in array){
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
        for(microVideoDetailModel *newsModel in array){
            NSDictionary *dic = [newsModel mj_keyValues];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
            if(data){
                NSString *ID = [[NSUUID UUID]UUIDString];
                [homeNewsDetailDBCacheModel createOrUpdateInRealm:realm withValue:@{@"ID" : ID,@"data" : data}];
            }
        }
    }
    [realm commitWriteTransaction];
    
}

-(NSMutableArray *)TT_quertNewsDetailData:(NSString *)category{
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dbName = [NSString stringWithFormat:@"TT_NewsDetail_%@.realm",category];
    NSString *filePath = [dbPath stringByAppendingPathComponent:dbName];
    RLMRealm *realm = [RLMRealm realmWithURL:[NSURL URLWithString:filePath]];
    
    RLMResults *result = [homeNewsDetailDBCacheModel allObjectsInRealm:realm];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(homeNewsDetailDBCacheModel *model in result){
        NSMutableDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:model.data error:nil];
        if([category isEqualToString:@"essay_joke"]){
            homeNewsMiddleCoverViewModel *jokeModel = [[[homeNewsMiddleCoverViewModel alloc]init]mj_setKeyValues:dic];
            [dataArray addObject:jokeModel];
        }else if([category isEqualToString:@"video"]){
            videoContentModel *videoModel = [[[videoContentModel alloc]init]mj_setKeyValues:dic];
            [dataArray addObject:videoModel];
        }else{
            homeNewsSummaryModel *newsModel = [[[homeNewsSummaryModel alloc]init]mj_setKeyValues:dic];
            [dataArray addObject:newsModel];
        }
    }
    return dataArray;
}

@end
