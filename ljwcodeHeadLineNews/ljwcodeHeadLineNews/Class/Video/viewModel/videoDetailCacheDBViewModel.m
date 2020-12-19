//
//  videoDetailCacheDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoDetailCacheDBViewModel.h"
#import <MJExtension/MJExtension.h>

static int maxCacheVideoItem;

@interface videoDetailCacheDBViewModel()

@property(nonatomic,strong)FMDatabase *fmDataBase;

@end

@implementation videoDetailCacheDBViewModel

-(instancetype)init{
    if(self = [super init]){
        maxCacheVideoItem = 20;
    }
    return self;
}

-(void)createDBWithVideoCacheTable{
    if(![self.fmDataBase open]){
        
        NSLog(@"数据库打开失败");
        return;
    }
//    BOOL executeCreateTable = [self.fmDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS TTVideoDetailTable (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,media_name varchar NOT NULL,title varchar NOT NULL,video_play_info varchar,share_url varchar NOT NULL,video_duration integer NOT NULL,avatar_url varchar NOT NULL,detail_video_large_image varchar NOT NULL,video_watch_count integer NOT NULL,video_id varchar NOT NULL)"];
    BOOL executeCreateTable = [self.fmDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS TTVideoDetailTable (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,dic blob NOT NULL)"];
    if(executeCreateTable){
        NSLog(@"videoCache创表成功");
    }else{
        NSLog(@"videoCache创表失败");
    }
}

-(BOOL)IsExistsVideoCacheTable{
    NSString *existsSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTVideoDetailTable'" ];
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

-(void)InsertVideoCacheWithDB:(NSArray *)dataArray{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    [self.fmDataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for(videoDetailModel *model in dataArray){
            NSDictionary *dataDic = [model mj_keyValues];
            NSData *data = nil;
            NSError *Error;
            if(@available (iOS 11.0, *)){
                data = [NSKeyedArchiver archivedDataWithRootObject:dataDic requiringSecureCoding:YES error:&Error];
            }else{
                data = [NSKeyedArchiver archivedDataWithRootObject:dataDic];
            }
            if(!data && Error){
                NSLog(@"缓存失败 %@",Error);
            }
            
            BOOL executeInsertDB = [self.fmDataBase executeUpdate:@"insert into TTVideoDetailTable (dic) values (?)",dataDic];
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
        NSData *data = [result objectForColumn:@"dic"];
        NSError *Error;
        NSDictionary *dic = [NSDictionary dictionary];
        if(@available (iOS 11.0,*)){
            dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:data error:&Error];
        }else{
            dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        if(dic){
            videoDetailModel *model = [[videoDetailModel alloc]mj_setKeyValues:dic];
            [array addObject:model];
        }
    }
    return array;
}

-(void)updateVideoCache{
    /*
     首次安装启动app开始缓存当前界面的数据，以防下次启动到开界面时展示空白界面
     
     */
}

#pragma mark ------- lazy load

-(FMDatabase *)fmDataBase{
    if(!_fmDataBase){
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbFile = [dbPath stringByAppendingPathComponent:@"TTDataBase.sqlite"];
        _fmDataBase = [FMDatabase databaseWithPath:dbFile];
        [_fmDataBase open];
    }
    return _fmDataBase;
}


@end
