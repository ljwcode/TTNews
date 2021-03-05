//
//  homeArticleContentViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeArticleContentViewModel : NSObject

@property(nonatomic,strong)RACCommand *ArticleContentCommand;

-(NSString *)TT_getHTMLString;

@end

NS_ASSUME_NONNULL_END
