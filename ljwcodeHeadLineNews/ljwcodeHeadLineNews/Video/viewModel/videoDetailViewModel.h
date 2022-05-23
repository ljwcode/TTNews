//
//  videoDetailViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTBaseViewModel.h"
#import <RACCommand.h>

NS_ASSUME_NONNULL_BEGIN

@interface videoDetailViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *videoDetailCommand;

@end

NS_ASSUME_NONNULL_END
