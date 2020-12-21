//
//  videoDetailCacheDBViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "videoContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface videoDetailCacheDBViewModel : NSObject

-(void)createDBWithVideoCacheTable:(NSString *)category;

-(BOOL)IsExistsVideoCacheTable:(NSString *)category;

-(void)InsertVideoCacheWithDB:(NSArray *)dataArray VideoCategory:(NSString *)category;

-(NSMutableArray *)queryDBTableWithVideoContent:(NSString *)category;

@end

NS_ASSUME_NONNULL_END
