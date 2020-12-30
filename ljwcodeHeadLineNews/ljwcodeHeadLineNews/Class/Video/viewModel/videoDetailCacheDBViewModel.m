//
//  videoDetailCacheDBViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoDetailCacheDBViewModel.h"
#import <MJExtension/MJExtension.h>

@implementation TTVideoDetailArrayModel

@end

@interface videoDetailCacheDBViewModel()

@end

@implementation videoDetailCacheDBViewModel

-(void)TT_saveVideoDataModel:(NSArray *)array{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"path = %@",path);
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    for (videoContentModel *model in array) {
        NSDictionary *dic = [model mj_keyValues];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:YES error:nil];
        [TTVideoDetailArrayModel createInRealm:realm withValue:@{@"data": data}];
        [realm addObject:self.arrayModel];
    }
    [realm commitWriteTransaction];
}

-(NSMutableArray *)TT_queryVideoDataModel{
    RLMResults *result = [TTVideoDetailArrayModel allObjects];
    NSLog(@"result = %@",result);
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(int i = 0;i < result.count;i++){
        RLMResults *data = [result[i] objectsWhere:@"data"];
        
        NSDictionary *dic = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSMutableArray class] fromData:data error:nil];
        videoContentModel *Contentmodel = [[[videoContentModel alloc]init]mj_setKeyValues:dic];
        [dataArray addObject:Contentmodel];
    }
    
    return dataArray;
}

#pragma mark ---- lazy load
-(TTVideoDetailArrayModel *)arrayModel{
    if(!_arrayModel){
        _arrayModel = [[TTVideoDetailArrayModel alloc]init];
    }
    return _arrayModel;
}

@end
