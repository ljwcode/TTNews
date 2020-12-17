//
//  homeNewsDetailDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/17.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeNewsDetailDBViewModel.h"

static int maxCacheVideo = 20;

@interface homeNewsDetailDBViewModel()

@property(nonatomic,strong)FMDatabase *fmDataBase;

@end

@implementation homeNewsDetailDBViewModel

-(void)createDBWithVideoCacheTable{
    if(![self.fmDataBase open]){
        
        NSLog(@"数据库打开失败");
        return;
    }
    BOOL executeCreateTable = [self.fmDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS TTVideoDetailTable (id integer PRIMARY KEY AUTOINCREMENT NOT NULL,media_name varchar NOT NULL,title varchar NOT NULL,video_play_info varchar NOT NULL,share_url varchar NOT NULL,video_duration varchar NOT NULL,avatar_url varchar NOT NULL,detail_video_large_image varchar NOT NULL,video_watch_count integer NOT NULL,video_id varchar NOT NULL)"];
    if(executeCreateTable){
        NSLog(@"videoCache创表成功");
    }else{
        NSLog(@"videoCache创表失败");
    }
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
