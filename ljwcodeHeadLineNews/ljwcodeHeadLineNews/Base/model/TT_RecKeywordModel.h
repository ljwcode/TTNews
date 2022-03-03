//
//  TT_RecKeywordModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/2.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface tag_icon : NSObject

@property(nonatomic,assign)int height;

@property(nonatomic,assign)int width;

@property(nonatomic,copy)NSString *url_list;

@end

@interface extra_info : NSObject

@property(nonatomic,copy)NSString *enable_prefetch;

@property(nonatomic,copy)NSString *hotboard_label;

@property(nonatomic,copy)NSString *is_trending_hotboard_source;

@property(nonatomic,copy)NSString *sentence_id;

@property(nonatomic,strong)tag_icon *tag_icon;

@end

@interface params : NSObject

@property(nonatomic,assign)int challenge_id;

@property(nonatomic,strong)extra_info *extra_info;

@property(nonatomic,copy)NSString *reason;

@property(nonatomic,copy)NSString *recommend_reason;

@end

@interface TT_RecKeywordModel : NSObject

@property(nonatomic,copy)NSString *word;

@property(nonatomic,copy)NSString *id;

@property(nonatomic,copy)NSString *word_type;

@property(nonatomic,strong)params *params;

@end

NS_ASSUME_NONNULL_END
