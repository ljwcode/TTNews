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

@property(nonatomic,strong)FMDatabase *fmDataBase;

@end

@implementation videoDetailCacheDBViewModel

-(instancetype)init{
    if(self = [super init]){
        [self.fmDataBase open];
    }
    return self;
}

-(void)createDBWithVideoCacheTable{
    if(![self.fmDataBase open]){
        
        NSLog(@"数据库打开失败");
        return;
    }
    NSString *sql = @"CREATE TABLE IF NOT EXISTS TTVideoDetailTable (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,data blob)";
    BOOL executeCreateTable = [self.fmDataBase executeUpdate:sql];
    if(executeCreateTable){
        NSLog(@"videoCache创表成功");
        /*
         创建该数据表的触发器 设置最大存储行数为20行，当超过20行时，将会触发删除最早插入的那一行，始终保留最大行数为20行
         */
        NSString *sql = @"CREATE TRIGGER IF NOT EXISTS Trl AFTER INSERT ON TTVideoDetailTable when (select count(*) from TTVideoDetailTable)>20 BEGIN delete from TTVideoDetailTable where id in (select id from TTVideoDetailTable order by id limit 0,1);END;";
        if([self.fmDataBase executeUpdate:sql]){
            NSLog(@"触发器设置成功");
        }else{
            NSLog(@"触发器设置失败");
        }
    }else{
        NSLog(@"videoCache创表失败");
        return;
    }
}

-(BOOL)IsExistsVideoCacheTable{
    NSString *existsSql = @"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTVideoDetailTable'";
    FMResultSet *result = [self.fmDataBase executeQuery:existsSql];
    if ([result next]) {
        NSInteger count = [result intForColumn:@"count"];
        NSLog(@"The table count: %li", count);
        if (count == 1) {
            NSLog(@"videoCache数据表已存在");
            return YES;
        }
    }
    return NO;
}

-(void)InsertVideoCacheWithDB:(NSArray *)dataArray{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    [self.fmDataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for(videoContentModel *model in dataArray){
            NSDictionary *dataDic = [model mj_keyValues];
            NSError *Error = nil;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDic requiringSecureCoding:YES error:&Error];
            if(!data && Error){
                NSLog(@"Error = %@",Error);
            }
            NSString *sql = @"INSERT INTO TTVideoDetailTable(data) VALUES (?)";
            BOOL executeInsertDB = [self.fmDataBase executeUpdate:sql,data];
            if(executeInsertDB){
                NSLog(@"videoCache数据插入成功");
            }else{
                NSLog(@"videoCache数据插入失败");
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
    NSString *sql = @"select * from TTVideoDetailTable";
    FMResultSet *result = [self.fmDataBase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSData *data = [result dataForColumn:@"dic"];
        NSError *Error;
        NSDictionary *dic;
        dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:data error:&Error];
        if(dic){
            videoContentModel *model = [[videoContentModel alloc]mj_setKeyValues:dic];
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

-(void)createDBFilePath:(NSString *)category{
    NSString *DBPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *DBName = [NSString stringWithFormat:@"TTDB_%@.sqlite",category];
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
