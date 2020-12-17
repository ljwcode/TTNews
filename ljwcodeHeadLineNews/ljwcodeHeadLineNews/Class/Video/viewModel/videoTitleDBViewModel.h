//
//  videoTitleDBViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/17.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "videoTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface videoTitleDBViewModel : NSObject

@property(nonatomic,strong)FMDatabase *fmDataBase;

-(void)createDBCacheTable;

-(BOOL)DBTableIsExists;

-(void)InsertDBWithModel:(videoTitleModel *)model;

-(NSMutableArray *)queryDataBase;

@end

NS_ASSUME_NONNULL_END
