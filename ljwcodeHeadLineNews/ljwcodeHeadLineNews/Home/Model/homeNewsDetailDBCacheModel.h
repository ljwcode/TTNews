//
//  homeNewsDetailDBCacheModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/31.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeNewsDetailDBCacheModel : RLMObject

@property NSData *data;

@property NSString *ID;



@end

NS_ASSUME_NONNULL_END
