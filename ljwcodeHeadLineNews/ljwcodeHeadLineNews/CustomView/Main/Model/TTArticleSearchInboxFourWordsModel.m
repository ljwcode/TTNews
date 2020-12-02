//
//  TTArticleSearchInboxFourWordsModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTArticleSearchInboxFourWordsModel.h"

@implementation TTArticleSearchInboxFourWordsModel

-(instancetype)init{
    if(self = [super init]){
        self.homepage_search_suggest = @"";
        self.recommend_reason = @"";
        self.word = @"";
        self.recommend_reason = @"";
    }
    return self;
}

@end
