//
//  TTSearchSuggestionViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TTBaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTSearchSuggestionViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *SearchSuggestionCommand;

@end

NS_ASSUME_NONNULL_END
