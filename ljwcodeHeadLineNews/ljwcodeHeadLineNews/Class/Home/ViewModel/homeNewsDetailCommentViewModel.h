//
//  homeNewsDetailCommentViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/9.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeNewsDetailCommentViewModel : NSObject

@property(nonatomic,strong)RACCommand *newsDetailCommend;

@end

NS_ASSUME_NONNULL_END
