//
//  TT_NewsContentImgModel.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/3/11.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TT_NewsContentImgModel : NSObject

@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)CGFloat width;

@property(nonatomic,copy)NSString *url;
@end

NS_ASSUME_NONNULL_END
