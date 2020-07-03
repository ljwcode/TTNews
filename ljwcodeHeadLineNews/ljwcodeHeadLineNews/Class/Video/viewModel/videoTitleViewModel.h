//
//  videoTitleViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeBaseViewModel.h"
#import <RACCommand.h>

NS_ASSUME_NONNULL_BEGIN

@interface videoTitleViewModel : ljwcodeBaseViewModel

@property(nonatomic,strong)RACCommand *videoCommand;

@end

NS_ASSUME_NONNULL_END
