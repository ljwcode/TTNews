//
//  videoDetailCacheDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoDetailCacheDBViewModel.h"

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
    BOOL executeCreateTable = [self.fmDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS TTVideoDetailTable (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,media_name varchar NOT NULL,title varchar NOT NULL,video_play_info varchar,share_url varchar NOT NULL,video_duration integer NOT NULL,avatar_url varchar NOT NULL,detail_video_large_image varchar NOT NULL,video_watch_count integer NOT NULL,video_id varchar NOT NULL)"];
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

-(void)InsertVideoCacheWithDB:(videoContentModel *)model{
    if(![self.fmDataBase open]){
        NSLog(@"数据库打开失败");
        return;
    }
    [self.fmDataBase beginTransaction];
    BOOL isRollBack = NO;
    @try {
        BOOL executeInsertDB = [self.fmDataBase executeUpdate:@"insert into TTVideoDetailTable (media_name,title,video_play_info,share_url,video_duration,avatar_url,detail_video_large_image,video_watch_count,video_id) values (?,?,?,?,?,?,?,?,?)",model.detailModel.media_name,model.detailModel.title,model.detailModel.video_play_info,model.detailModel.share_url,@(model.detailModel.video_duration),model.detailModel.media_info.avatar_url,model.detailModel.video_detail_info.detail_video_large_image,@(model.detailModel.video_detail_info.video_watch_count),model.detailModel.video_detail_info.video_id];
        if(executeInsertDB){
            NSLog(@"videoCache数据插入成功");
        }else{
            NSLog(@"videoCache数据插入失败");
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
        videoContentModel *model = [[videoContentModel alloc]init];
        model.detailModel.media_name = [result objectForColumn:@"media_name"];
        model.detailModel.title = [result objectForColumn:@"title"];
        model.detailModel.video_play_info = [result objectForColumn:@"video_play_info"];
        model.detailModel.share_url = [result objectForColumn:@"share_url"];
        model.detailModel.video_duration = [result intForColumn:@"video_duration"];
        model.detailModel.media_info.avatar_url = [result objectForColumn:@"avatar_url"];
        model.detailModel.video_detail_info.detail_video_large_image = [result objectForColumn:@"detail_video_large_image"];
        model.detailModel.video_detail_info.video_watch_count = [result intForColumn:@"video_watch_count"];
        model.detailModel.video_detail_info.video_id = [result objectForColumn:@"video_id"];
        [array addObject:model];
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
