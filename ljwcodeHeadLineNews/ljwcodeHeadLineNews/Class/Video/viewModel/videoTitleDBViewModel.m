//
//  videoTitleDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/17.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoTitleDBViewModel.h"

@interface videoTitleDBViewModel()

@property(nonatomic,strong)FMDatabaseQueue *dataBaseQueue;

@end

@implementation videoTitleDBViewModel

-(void)createDBCacheTable{
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if(![db open]){
            NSLog(@"数据库打开失败");
            return;
        }
        BOOL executeDBUpdate = [db executeUpdate:@"create table if not exists TTVideoTitle(id integer primary key autoincrement,name varchar NOT NULL,category varchar NOT NULL,category_type integer NOT NULL,flags integer NOT NULL,icon_url varchar NOT NULL,tip_new integer NOT NULL,type integer NOT NULL,web_url varchar NOT NULL)"];
        if(executeDBUpdate){
            NSLog(@"VideoTitle创建数据表成功");
        }else{
            NSLog(@"VideoTitle创建数据表失败");
        }
    }];
}

-(BOOL)DBTableIsExists{
    NSString *existsSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTVideoTitle'" ];
    __block FMResultSet *result;
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeQuery:existsSql];
    }];
    if ([result next]) {
        NSInteger count = [result intForColumn:@"count"];
        NSLog(@"The table count: %li", count);
        if (count == 1) {
            NSLog(@"videoTitle数据表已存在");
            return YES;
        }
    }
    return NO;
}

-(void)InsertDBWithModel:(videoTitleModel *)model{
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if(![db open]){
            NSLog(@"数据库打开失败");
            return;
        }
        [db beginTransaction];
        BOOL isRollBack = NO;
        @try {
            BOOL result = [db executeUpdate:@"insert into TTVideoTitle (name,category,category_type,flags,icon_url,tip_new,type,web_url) values (?,?,?,?,?,?,?,?)",model.name,model.category,@(model.category_type),@(model.flags),model.icon_url,@(model.tip_new),@(model.type),model.web_url];
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

-(NSMutableArray *)queryDataBase{
    NSString *Sql = @"select * from TTVideoTitle";
    __block FMResultSet *result;
    [self.dataBaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeQuery:Sql];
    }];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        videoTitleModel *titleModel = [[videoTitleModel alloc]init];
        titleModel.name = [result objectForColumn:@"name"];
        titleModel.category = [result objectForColumn:@"category"];
        [array addObject:titleModel];
    }
    return array;
}

#pragma mark ----- lzay load

-(FMDatabaseQueue *)dataBaseQueue{
    if(!_dataBaseQueue){
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbFileName = [dbPath stringByAppendingPathComponent:@"TT_VideoTitle_DataBase.sqlite"];
        _dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbFileName];
    }
    return _dataBaseQueue;
}

@end
