//
//  homeNewsCellViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface homeNewsCellViewModel : ljwcodeBaseViewModel

@property(nonatomic,strong)RACCommand *newsCellViewCommand;

@end

NS_ASSUME_NONNULL_END
