//
//  homeNewsDetailDBViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/17.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface homeNewsDetailDBViewModel : NSObject

-(void)TT_saveHomeNewsDetailModel:(NSArray *)array TT_DetailCategory:(NSString *)category;

-(NSMutableArray *)TT_quertNewsDetailData:(NSString *)category;

@end

NS_ASSUME_NONNULL_END
