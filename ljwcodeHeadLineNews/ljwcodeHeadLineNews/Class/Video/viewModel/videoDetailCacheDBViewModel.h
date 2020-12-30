//
//  videoDetailCacheDBViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "videoContentModel.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTVideoDetailArrayModel : RLMObject

@property NSData *data;

@end

@interface videoDetailCacheDBViewModel : NSObject

@property(nonatomic,strong)TTVideoDetailArrayModel *arrayModel;

-(void)TT_saveVideoDataModel:(NSArray *)array;

-(NSMutableArray *)TT_queryVideoDataModel;

@end

NS_ASSUME_NONNULL_END
