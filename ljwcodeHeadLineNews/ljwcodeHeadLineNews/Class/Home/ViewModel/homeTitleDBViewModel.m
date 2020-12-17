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
    BOOL executeUpdate = [self.fmDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS TTHomeTitle (id integer PRIMARY KEY AUTOINCREMENT,name varchar NOT NULL,category varchar NOT NULL,concern_id varchar NOT NULL,flags integer NOT NULL,default_add integer NOT NULL,icon_url varchar NOT NULL,type integer NOT NULL,tip_new integer NOT NULL);"];
    if (executeUpdate) {
        NSLog(@"homeTitle创建表成功");
    } else {
        NSLog(@"homeTitle创建表失败");
    }
}

-(void)InsertDataWithDB:(homeTitleModel *)model{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    NSString *concern_id = @"1";
    NSString *icon_url = @"1";
    int flags = 1;
    int default_add = 1;
    int type = 1;
    int tip_new = 1;
    /*
     注意：在执行fmdb数据插入时，需要严格注意插入的数据类型是否匹配，否则容易产生crash
     例如int 类型数据插入传值时应该@（int）,而不能直接传如int
     */
    BOOL results = [self.fmDataBase executeUpdate:@"insert into TTHomeTitle (name,category,concern_id,flags,default_add,icon_url,type,tip_new) VALUES (?,?,?,?,?,?,?,?)",model.name,model.category,concern_id,@(flags),@(default_add),icon_url,@(type),@(tip_new)];
    if(results){
        NSLog(@"数据插入成功");
    }else{
        NSLog(@"数据插入失败");
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

-(NSMutableArray *)queryDBWithTitle{
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
        NSString *dbFileName = [dbPath stringByAppendingPathComponent:@"TTDataBase.sqlite"];//设置数据库名称
        _fmDataBase = [FMDatabase databaseWithPath:dbFileName];//创建并获取数据库信息
        [_fmDataBase open];
    }
    return _fmDataBase;
}

@end
