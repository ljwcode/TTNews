//
//  homeTitleDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTitleDBViewModel.h"

@interface homeTitleDBViewModel()

@property(nonatomic,strong)FMDatabaseQueue *dataBaseQueue;

@end

@implementation homeTitleDBViewModel

-(void)createTitleCacheDb{
    __block BOOL executeDBUpdate;
    
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if(![db open]){
            NSLog(@"数据库打开失败");
            return;
        }
        executeDBUpdate = [db executeUpdate:@"create table if not exists TTHomeTitle(id integer primary key autoincrement,name varchar NOT NULL,category varchar NOT NULL,category_type integer NOT NULL,flags integer NOT NULL,icon_url varchar NOT NULL,tip_new integer NOT NULL,type integer NOT NULL,web_url varchar NOT NULL)"];
        
    }];
    if(executeDBUpdate){
        NSLog(@"HomeTitle创建数据表成功");
    }else{
        NSLog(@"HomeTitle创建数据表失败");
    }
}

-(void)InsertDataWithDB:(homeTitleModel *)model{
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if(![db open]){
            NSLog(@"数据库打开失败");
            return;
        }
        [db beginTransaction];
        BOOL isRollBack = NO;
        @try {
            BOOL result = [db executeUpdate:@"insert into TTHomeTitle (name,category,category_type,flags,icon_url,tip_new,type,web_url) values (?,?,?,?,?,?,?,?)",model.name,model.category,@(model.category_type),@(model.flags),model.icon_url,@(model.tip_new),@(model.type),model.web_url];
            if(!result){
                NSLog(@"数据插入失败");
                return;
            }
            NSLog(@"数据插入成功");
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

-(BOOL)DBTableISExist{
    NSString *existsSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTHomeTitle'" ];
    __block FMResultSet *result;
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeQuery:existsSql];
    }];
    if ([result next]) {
        NSInteger count = [result intForColumn:@"count"];
        NSLog(@"The table count: %li", count);
        if (count == 1) {
            NSLog(@"homeTitle数据表已存在");
            return YES;
        }
    }
    return NO;
}

-(NSMutableArray *)queryDataBase{
    NSString *Sql = @"select * from TTHomeTitle";
    __block FMResultSet *result;
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeQuery:Sql];
    }];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        homeTitleModel *titleModel = [[homeTitleModel alloc]init];
        titleModel.name = [result objectForColumn:@"name"];
        titleModel.category = [result objectForColumn:@"category"];
        [array addObject:titleModel];
    }
    return array;
}

#pragma mark ------ lazy load

-(FMDatabaseQueue *)dataBaseQueue{
    if(!_dataBaseQueue){
        NSString *dbPath = [[NSString alloc]init];
        dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"数据库地址为%@",dbPath);
        NSString *dbFileName = [dbPath stringByAppendingPathComponent:@"TT_HomeTitle_DataBase.sqlite"];//设置数据库名称
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbFileName];//创建并获取数据库信息
    }
    return _dataBaseQueue;
}

@end
