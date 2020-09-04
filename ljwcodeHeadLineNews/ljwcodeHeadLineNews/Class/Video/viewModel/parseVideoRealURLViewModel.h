//
//  parseVideoRealURLViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/9/4.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "ljwcodeBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface parseVideoRealURLViewModel : ljwcodeBaseViewModel

@property(nonatomic,strong)RACCommand *VideoRealURLCommand;

@end

NS_ASSUME_NONNULL_END
