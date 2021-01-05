//
//  TTArticleSearchInboxFourWordsModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/12/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTArticleSearchInboxFourWordsModel : NSObject

@property(nonatomic,copy)NSString *homepage_search_suggest;

/*
 id = 6900506536557942023;
                 or = "qohr:211 qv:260 qvwgr:3";
                 "recommend_reason" = "";
                 word = "\U6df1\U822aZH9247\U5904\U7406\U7ed3\U679c";
                 "words_type" = "";
 */

@property(nonatomic,copy)NSString *recommend_reason;

@property(nonatomic,copy)NSString *word;

@property(nonatomic,copy)NSString *words_type;

@end


NS_ASSUME_NONNULL_END
