//
//  homeTitleViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface homeTitleViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *titleCommand;

@end

NS_ASSUME_NONNULL_END
