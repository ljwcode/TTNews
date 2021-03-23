//
//  homeTitleDBViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "homeTitleModel.h"
#import <FMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface homeTitleDBViewModel : NSObject

-(void)createTitleCacheDb;

-(void)InsertDataWithDB:(homeTitleModel *)model;

-(BOOL)DBTableISExist;

-(NSMutableArray *)queryDataBase;

@end

NS_ASSUME_NONNULL_END
