//
//  homeArticleContentModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeArticleContentModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,strong)NSArray *image_detail;

@end

NS_ASSUME_NONNULL_END
