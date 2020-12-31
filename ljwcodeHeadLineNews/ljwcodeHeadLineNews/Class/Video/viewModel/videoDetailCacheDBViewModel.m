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

@end

@implementation videoDetailCacheDBViewModel

-(void)TT_saveVideoDataModel:(NSArray *)array{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"path = %@",path);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        for (videoContentModel *model in array) {
            NSDictionary *dic = [model mj_keyValues];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
            if(data){
                NSString *ID = [[NSUUID UUID]UUIDString];
                [TTVideoDetailArrayModel createOrUpdateInRealm:realm withValue:@{@"ID" : ID,@"data" : data}];
            }
        }
        [realm commitWriteTransaction];
    });
}

-(NSMutableArray *)TT_queryVideoDataModel{
    RLMResults *result = [TTVideoDetailArrayModel allObjects];
    NSLog(@"result = %@",result);
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(TTVideoDetailArrayModel *model in result){
        NSMutableDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:model.data error:nil];
        videoContentModel *contentModel = [[[videoContentModel alloc]init]mj_setKeyValues:dic];
        [dataArray addObject:contentModel];
    }
    
    return dataArray;
}
@end
