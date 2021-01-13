//
//  TT_tabBarViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTBaseViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TT_tabBarViewModel : TTBaseViewModel

@property(nonatomic,strong)RACCommand *tabBarCommand;

@end

NS_ASSUME_NONNULL_END
