//
//  homeTitleDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTitleDBViewModel.h"

@interface homeTitleDBViewModel()

@property(nonatomic,strong)FMDatabase *fmDataBase;

@end

@implementation homeTitleDBViewModel

-(void)createTitleCacheDb{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    BOOL executeDBUpdate = [self.fmDataBase executeUpdate:@"create table if not exists TTHomeTitle(id integer primary key autoincrement,name varchar NOT NULL,category varchar NOT NULL,category_type integer NOT NULL,flags integer NOT NULL,icon_url varchar NOT NULL,tip_new integer NOT NULL,type integer NOT NULL,web_url varchar NOT NULL)"];
    if(executeDBUpdate){
        NSLog(@"HomeTitle创建数据表成功");
    }else{
        NSLog(@"HomeTitle创建数据表失败");
    }
}

-(void)InsertDataWithDB:(homeTitleModel *)model{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    [self.fmDataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        BOOL result = [self.fmDataBase executeUpdate:@"insert into TTHomeTitle (name,category,category_type,flags,icon_url,tip_new,type,web_url) values (?,?,?,?,?,?,?,?)",model.name,model.category,@(model.category_type),@(model.flags),model.icon_url,@(model.tip_new),@(model.type),model.web_url];
        if(!result){
            NSLog(@"数据插入失败");
            return;
        }
        NSLog(@"数据插入成功");
    } @catch (NSException *exception) {
        isRollBack = YES;
        [self.fmDataBase rollback];
    } @finally {
        if(!isRollBack){
            [self.fmDataBase commit];
        }
    }
}

-(BOOL)DBTableISExist{
    NSString *existsSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTHomeTitle'" ];
    FMResultSet *result = [self.fmDataBase executeQuery:existsSql];
    if ([result next]) {
        NSInteger count = [result intForColumn:@"count"];
        NSLog(@"The table count: %li", count);
        if (count == 1) {
            NSLog(@"数据表已存在");
            return YES;
        }
    }
    return NO;
}

-(NSMutableArray *)queryDataBase{
    NSString *Sql = @"select * from TTHomeTitle";
    FMResultSet *result = [self.fmDataBase executeQuery:Sql];
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

-(FMDatabase *)fmDataBase{
    if(!_fmDataBase){
        NSString *dbPath = [[NSString alloc]init];
        dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"数据库地址为%@",dbPath);
        NSString *dbFileName = [dbPath stringByAppendingPathComponent:@"TT_HomeTitle_DataBase.sqlite"];//设置数据库名称
        _fmDataBase = [FMDatabase databaseWithPath:dbFileName];//创建并获取数据库信息
        [_fmDataBase open];
    }
    return _fmDataBase;
}

@end
