//
//  XGVideoCommentViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/23.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTBaseViewModel.h"
#import <RACCommand.h>

NS_ASSUME_NONNULL_BEGIN

@interface XGVideoCommentViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *ComRacCommand;

@end

NS_ASSUME_NONNULL_END
