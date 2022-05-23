//
//  XGVideoDetailRecommendViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/22.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RACCommand.h>
#import "TTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface XGVideoDetailRecommendViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *videoRecCommand;

@end

NS_ASSUME_NONNULL_END
