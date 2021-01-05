//
//  TTDBCacheSearchKeywordViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTDBCacheSearchKeywordViewModel : NSObject

-(void)createDBWithSearchKeywordTable;

-(BOOL)IsExistsKeywordCacheTable;

-(void)InsertSearchKeywordWithDB:(NSArray *)dataArray;

-(NSMutableArray *)queryDBTableWithVideoContent;

@end

NS_ASSUME_NONNULL_END
