//
//  homeTitleDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTitleDBViewModel.h"
#import "homeTitleViewModel.h"

@interface homeTitleDBViewModel()

@property(nonatomic,strong)homeTitleViewModel *titleViewModel;

@end

@implementation homeTitleDBViewModel

-(void)createTitleCacheDb{
    
    if ([self.fmDataBase open]) {
        NSLog(@"数据库打开成功");
        /*
         创建数据表
          */
        BOOL executeUpdate = [self.fmDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS TTHomeTitle (id integer PRIMARY KEY AUTOINCREMENT,name varchar NOT NULL,category varchar NOT NULL,concern_id varchar NOT NULL,flags integer NOT NULL,default_add integer NOT NULL,icon_url varchar NOT NULL,type integer NOT NULL,tip_new integer NOT NULL);"];
        if (executeUpdate) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
    }else{
        NSLog(@"数据库打开失败");
    }
}

-(void)InsertDataWithDB:(homeTitleModel *)model{
    BOOL isOpen = [self.fmDataBase open];
    if(isOpen){
        NSLog(@"打开数据库成功");
        model.concern_id = @"";
        model.icon_url = @"";
        model.flags = 0;
        model.default_add = 0;
        model.type = 0;
        model.tip_new = 0;
        BOOL results = [self.fmDataBase executeUpdate:@"insert into TTHomeTitle (name,category,concern_id,flags,default_add,icon_url,type,tip_new) VALUES (?,?,?,?,?,?,?,?)",model.name,model.category,model.concern_id,model.flags,model.default_add,model.icon_url,model.type,model.tip_new];
        if(results){
            NSLog(@"数据插入成功");
            FMResultSet *result = [self.fmDataBase executeQuery:@"select * from TTHomeTitle"];
            while([result next]){
                int ID = [result intForColumn:@"id"];
                NSString *title = [result objectForColumn:@"titleName"];
                NSLog(@"插入数据为%d : title = %@",ID,title);
            }
        }else{
            NSLog(@"数据插入失败");
        }
    }else{
        NSLog(@"打开数据库失败");
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
    NSString *delRepeatSql = @"select distinct titleName from TTHomeTitle"; //去重
    FMResultSet *result = [self.fmDataBase executeQuery:delRepeatSql];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSString *name = [result objectForColumn:@"titleName"];
        NSLog(@"name = %@",name);
        [array addObject:name];
    }
    return array;
}

#pragma mark ------ lazy load

-(homeTitleViewModel *)titleViewModel{
    if(!_titleViewModel){
        _titleViewModel = [[homeTitleViewModel alloc]init];
    }
    return _titleViewModel;
}

-(FMDatabase *)fmDataBase{
    if(!_fmDataBase){
        NSString *dbPath = [[NSString alloc]init];
        dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"数据库地址为%@",dbPath);
        NSString *fileName = [dbPath stringByAppendingPathComponent:@"homeTitle.sqlite"];//设置数据库名称
        _fmDataBase = [FMDatabase databaseWithPath:fileName];//创建并获取数据库信息
        [_fmDataBase open];
    }
    return _fmDataBase;
}

@end
