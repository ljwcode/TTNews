//
//  TTDBCacheSearchKeywordViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTDBCacheSearchKeywordViewModel.h"
#import <FMDB/FMDB.h>
#import <MJExtension/MJExtension.h>
#import "TTArticleSearchInboxFourWordsModel.h"

@interface TTDBCacheSearchKeywordViewModel()

@property(nonatomic,strong)FMDatabaseQueue *dataBaseQueue;

@end

@implementation TTDBCacheSearchKeywordViewModel

-(void)createDBWithSearchKeywordTable{
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if(![db open]){
            NSLog(@"数据库打开失败");
            return;
        }
        NSString *sql = @"CREATE TABLE IF NOT EXISTS TTSearchKeyword (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,keyword varchar NOT NULL)";
        BOOL executeCreateTable = [db executeUpdate:sql];
        if(executeCreateTable){
            NSLog(@"keyword创表成功");
        }else{
            NSLog(@"keyword创表失败");
            return;
        }
    }];
}

-(BOOL)IsExistsKeywordCacheTable{
    NSString *existsSql = @"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTSearchKeyword'";
    __block FMResultSet *result;
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeQuery:existsSql];
    }];
    if ([result next]) {
        NSInteger count = [result intForColumn:@"count"];
        NSLog(@"The table count: %li", count);
        if (count == 1) {
            NSLog(@"keyword数据表已存在");
            return YES;
        }
    }
    return NO;
}

-(void)InsertSearchKeywordWithDB:(NSArray *)dataArray{
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if(![db open]){
            NSLog(@"数据库打开失败");
            return;
        }
        [db beginTransaction];
        BOOL isRollBack = NO;
        @try {
            for(TTArticleSearchInboxFourWordsModel *model in dataArray){
                NSDictionary *dataDic = [model mj_keyValues];
                NSError *Error = nil;
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDic requiringSecureCoding:YES error:&Error];
                if(!data && Error){
                    NSLog(@"Error = %@",Error);
                }
                NSString *sql = @"INSERT INTO TTSearchKeyword(keyword) VALUES (?)";
                BOOL executeInsertDB = [db executeUpdate:sql,data];
                if(executeInsertDB){
                    NSLog(@"keyword数据插入成功");
                    NSString *sql = @"CREATE TRIGGER IF NOT EXISTS Trl AFTER INSERT ON TTSearchKeyword when (select count(*) from TTSearchKeyword)>4 BEGIN delete from TTSearchKeyword where id in (select id from TTSearchKeyword order by id limit 0,1);END;";
                    BOOL triggerUpdate = [db executeUpdate:sql];
                }else{
                    NSLog(@"keyword数据插入失败");
                }
            }
            
        } @catch (NSException *exception) {
            isRollBack = YES;
            [db rollback];
        } @finally {
            if(!isRollBack){
                [db commit];
            }
        }
    }];
   
}

-(NSMutableArray *)queryDBTableWithVideoContent{
    NSString *sql = @"select * from TTSearchKeyword";
    __block FMResultSet *result;
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeQuery:sql];
    }];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSData *data = [result dataForColumn:@"keyword"];
        NSError *Error;
        NSDictionary *dic;
        dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:data error:&Error];
        if(dic){
            TTArticleSearchInboxFourWordsModel *model = [[[TTArticleSearchInboxFourWordsModel alloc]init]mj_setKeyValues:dic];
            [array addObject:model];
        }
    }
    return array;
}

#pragma mark ------- lazy load

-(FMDatabaseQueue *)dataBaseQueue{
    if(!_dataBaseQueue){
        NSString *dbPath = [[NSString alloc]init];
        dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"数据库地址为%@",dbPath);
        NSString *dbFileName = [dbPath stringByAppendingPathComponent:@"TTDB_SearchKeyword.sqlite"];//设置数据库名称
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbFileName];//创建并获取数据库信息
    }
    return _dataBaseQueue;
}

@end
