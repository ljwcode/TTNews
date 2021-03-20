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
#import "TTXGVideoListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface videoDetailCacheDBViewModel : NSObject

-(void)TT_saveXGVideoListDataModel:(NSArray *)array TT_VideoCategory:(NSString *)category;

-(NSMutableArray *)TT_quertXGVideoListData:(NSString *)category;

@end

NS_ASSUME_NONNULL_END
