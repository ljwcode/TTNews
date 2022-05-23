//
//  homeMicroVideoRequestViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/9/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface homeMicroVideoRequestViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *microVideoCommand;

@end

NS_ASSUME_NONNULL_END
