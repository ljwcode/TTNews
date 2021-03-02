//
//  TT_RecommendSearchKeywordViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TT_RecommendSearchKeywordViewModel : NSObject

@property(nonatomic,strong)RACCommand *recSearchViewModel;

@end

NS_ASSUME_NONNULL_END
