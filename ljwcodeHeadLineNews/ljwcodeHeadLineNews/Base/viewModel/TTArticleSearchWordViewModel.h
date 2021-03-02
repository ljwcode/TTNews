//
//  TTArticleSearchWordViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/2.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTArticleSearchWordViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *searchWordCommand;

@end

NS_ASSUME_NONNULL_END
