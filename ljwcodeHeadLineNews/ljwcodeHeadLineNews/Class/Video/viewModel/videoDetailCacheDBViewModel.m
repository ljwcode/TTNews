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

-(void)createDBWithVideoCacheTable:(NSString *)category{
    if(![self.fmDataBase open]){
        
        NSLog(@"数据库打开失败");
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS TTVideoDetailTable_%@ (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,dic blob NOT NULL)",category];
    BOOL executeCreateTable = [self.fmDataBase executeUpdate:sql];
    /*
     插入一个分类管理，每次存取数据进入对应类别的数据表
     */
    
    if(executeCreateTable){
        NSLog(@"videoCache创表成功");
    }else{
        NSLog(@"videoCache创表失败");
        return;
    }
}

-(BOOL)IsExistsVideoCacheTable:(NSString *)category{
    NSString *existsSql = [NSString stringWithFormat:@"SELECT COUNT(*) count FROM sqlite_master where type='table' and name='TTVideoDetailTable_%@'",category ];
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

-(void)InsertVideoCacheWithDB:(NSArray *)dataArray VideoCategory:(nonnull NSString *)category{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"select count(*) from TTVideoDetailTable_%@",category];
    FMResultSet *result = [self.fmDataBase executeQuery:sql];
    int i;
    while([result next]){
        i++;
    }
    NSLog(@"数据行数为%d",i);
    [self.fmDataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        for(videoContentModel *model in dataArray){
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
            NSString *sql = [NSString stringWithFormat:@"insert into TTVideoDetailTable_%@ dic values %@",category,data];
            BOOL executeInsertDB = [self.fmDataBase executeUpdate:sql];
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

-(NSMutableArray *)queryDBTableWithVideoContent:(NSString *)category{
    NSString *sql = [NSString stringWithFormat:@"select * from TTVideoDetailTable_%@",category];
    FMResultSet *result = [self.fmDataBase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        NSData *data = [result dataForColumn:@"dic"];
        NSError *Error;
        NSDictionary *dic;
        if(@available (iOS 11.0,*)){
            dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:data error:&Error];
        }else{
            dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
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
