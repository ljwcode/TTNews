//
//  TTFontSizeChangeViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/21.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTFontSizeChangeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFontSizeChangeViewModel : NSObject

-(TTFontSizeChangeModel *)TT_getFontSizeJSONModelWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
