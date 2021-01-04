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
#import "TTSearchKeywordModel.h"

@interface TTDBCacheSearchKeywordViewModel()

@property(nonatomic,strong)FMDatabase *fmDataBase;

@end

@implementation TTDBCacheSearchKeywordViewModel

-(instancetype)init{
    if(self = [super init]){
        [self.fmDataBase open];
    }
    return self;
}

-(void)createDBWithSearchKeywordTable{
    if(![self.fmDataBase open]){
        
        NSLog(@"数据库打开失败");
        return;
    }
    NSString *sql = @"CREATE TABLE IF NOT EXISTS TTSearchKeyword (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,keyword varchar NOT NULL)";
    BOOL executeCreateTable = [self.fmDataBase executeUpdate:sql];
    if(executeCreateTable){
        NSLog(@"keyword创表成功");
    }else{
        NSLog(@"keyword创表失败");
        return;
    }
}

-(BOOL)IsExistsKeywordCacheTable{
    NSString *existsSql = @"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTSearchKeyword'";
    FMResultSet *result = [self.fmDataBase executeQuery:existsSql];
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
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    [self.fmDataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for(TTSearchKeywordModel *model in dataArray){
            NSDictionary *dataDic = [model mj_keyValues];
            NSError *Error = nil;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDic requiringSecureCoding:YES error:&Error];
            if(!data && Error){
                NSLog(@"Error = %@",Error);
            }
            NSString *sql = @"INSERT INTO TTSearchKeyword(keyword) VALUES (?)";
            BOOL executeInsertDB = [self.fmDataBase executeUpdate:sql,data];
            if(executeInsertDB){
                NSLog(@"keyword数据插入成功");
                NSString *sql = @"CREATE TRIGGER IF NOT EXISTS Trl AFTER INSERT ON TTSearchKeyword when (select count(*) from TTSearchKeyword)>1 BEGIN delete from TTSearchKeyword where id in (select id from TTSearchKeyword order by id limit 0,1);END;";
                BOOL triggerUpdate = [self.fmDataBase executeUpdate:sql];
            }else{
                NSLog(@"keyword数据插入失败");
            }
        }
        
    } @catch (NSException *exception) {
        isRollBack = YES;
        [self.fmDataBase rollback];
    } @finally {
        if(!isRollBack){
            [self.fmDataBase commit];
        }
    }
}

-(NSMutableArray *)queryDBTableWithVideoContent{
    NSString *sql = @"select * from TTSearchKeyword";
    FMResultSet *result = [self.fmDataBase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSData *data = [result dataForColumn:@"keyword"];
        NSError *Error;
        NSDictionary *dic;
        dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:data error:&Error];
        if(dic){
            TTSearchKeywordModel *model = [[TTSearchKeywordModel alloc]mj_setKeyValues:dic];
            [array addObject:model];
        }
    }
    return array;
}

-(void)updateVideoCache{
    /*
     首次安装启动app开始缓存当前界面的数据，以防下次启动到开界面时展示空白界面
     设置分类存储离线数据，单个类别最大数据量为20行，当插入新数据时，删除队尾数据（最旧的数据）
     db 1 2 3
     table 1 1 1
     */
    NSString *sql = @"update";
}

-(void)createDBFilePath{
    NSString *DBPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *DBName = [NSString stringWithFormat:@"TTDB_SearchKeyword.sqlite"];
    NSString *DBFile =[DBPath stringByAppendingPathComponent:DBName];
    NSLog(@"DBPath = %@",DBPath);
    self.fmDataBase = [FMDatabase databaseWithPath:DBFile];
    [self.fmDataBase open];
    NSLog(@"数据库已打开");
}

#pragma mark ------- lazy load

-(FMDatabase *)fmDataBase{
    if(!_fmDataBase){
        _fmDataBase = [[FMDatabase alloc]init];
    }
    return _fmDataBase;
}

@end
