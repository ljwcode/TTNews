//
//  homeNewsDetailRecSearchViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeNewsDetailRecSearchViewModel : NSObject

@property(nonatomic,strong)RACCommand *recSearchCommand;

@end

NS_ASSUME_NONNULL_END
