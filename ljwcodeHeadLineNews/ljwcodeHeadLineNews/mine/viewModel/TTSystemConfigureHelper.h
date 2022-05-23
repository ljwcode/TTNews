//
//  TTSystemConfigureHelper.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/5.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTSystemConfigureHelper : NSObject

+(TTSystemConfigureHelper *)shareInstance;

-(void)TT_ConfigurePreference;

@end

NS_ASSUME_NONNULL_END
