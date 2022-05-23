//
//  parseVideoRealURLViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/9/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface parseVideoRealURLViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *VideoRealURLCommand;

@end

NS_ASSUME_NONNULL_END
