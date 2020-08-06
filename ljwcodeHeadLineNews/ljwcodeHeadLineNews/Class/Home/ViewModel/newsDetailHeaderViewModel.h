//
//  newsDetailHeaderViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/6.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeBaseViewModel.h"
#import <RACCommand.h>

NS_ASSUME_NONNULL_BEGIN

@interface newsDetailHeaderViewModel : ljwcodeBaseViewModel

@property(nonatomic,strong)RACCommand *newsHeaderCommand;

@end

NS_ASSUME_NONNULL_END
