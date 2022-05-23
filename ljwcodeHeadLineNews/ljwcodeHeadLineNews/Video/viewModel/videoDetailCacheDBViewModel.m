//
//  videoDetailCacheDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoDetailCacheDBViewModel.h"
#import <MJExtension/MJExtension.h>

@interface videoDetailCacheDBViewModel()

@end

@implementation videoDetailCacheDBViewModel

-(void)TT_saveXGVideoListDataModel:(NSArray *)array TT_VideoCategory:(NSString *)category{
    
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dbName = [NSString stringWithFormat:@"TT_XGVideoList_%@.realm",category];
    NSString *filePath = [dbPath stringByAppendingPathComponent:dbName];
    RLMRealmConfiguration *dbConfig = [RLMRealmConfiguration defaultConfiguration];
    dbConfig.fileURL = [NSURL URLWithString:filePath];
    dbConfig.readOnly = NO;
    int currentVersion = 1.0;
    dbConfig.schemaVersion = currentVersion;
    [RLMRealmConfiguration setDefaultConfiguration:dbConfig];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        RLMRealm *realm = [RLMRealm realmWithURL:[NSURL URLWithString:filePath]];
        [realm beginWriteTransaction];
        if(array.count == 0){
            return;
        }
        for(videoContentModel *model in array){
            NSDictionary *dic = [model mj_keyValues];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
            if(data){
                NSString *ID = [[NSUUID UUID]UUIDString];
                [TTXGVideoListModel createOrUpdateInRealm:realm withValue:@{@"ID" : ID,@"data" : data}];
            }
        }
        [realm commitWriteTransaction];
    });
}

-(NSMutableArray *)TT_quertXGVideoListData:(NSString *)category{
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *dbName = [NSString stringWithFormat:@"TT_XGVideoList_%@.realm",category];
    NSString *filePath = [dbPath stringByAppendingPathComponent:dbName];
    RLMRealm *realm = [RLMRealm realmWithURL:[NSURL URLWithString:filePath]];
    
    RLMResults *result = [TTXGVideoListModel allObjectsInRealm:realm];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    if(result.count == 0){
        return dataArray;
    }
    for(TTXGVideoListModel *model in result){
        NSMutableDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:model.data error:nil];
        videoContentModel *ContentModel = [[[videoContentModel alloc]init]mj_setKeyValues:dic];
        [dataArray addObject:ContentModel];
    }
    return dataArray;
}
@end
