//
//  homeNewsModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 api接口和json转字典模型
 */
@interface homeNewsModel : NSObject

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)NSString *message;

@property(nonatomic,copy)NSString *post_content_hint;

@property(nonatomic,assign)int total_number;


@end

@interface filter_words : NSObject

@property(nonatomic,copy)NSString *name;

@end

@interface homeNewsImageModel : NSObject

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *width;

@property(nonatomic,copy)NSString *height;

@end

@interface homeNewsInfoModel : NSObject

@property(nonatomic,assign)NSTimeInterval publish_time;

@property(nonatomic,copy)NSString *abstract; //文章摘要

@property(nonatomic,copy)NSString *media_name;

@property(nonatomic,copy)NSString *display_url;

@property(nonatomic,strong)NSArray *image_list;

@property(nonatomic,copy)NSString *verified_content;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *keywords;

@property(nonatomic,copy)NSString *article_url;

@property(nonatomic,assign)int cell_type;

@property(nonatomic,assign)int read_count;

@property(nonatomic,assign)int comment_count;

@property(nonatomic,strong)homeNewsImageModel *middle_image;

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,strong)filter_words *filterWords;

@property(nonatomic,copy)NSString *item_id;

@property(nonatomic,copy)NSString *group_id;

@end

@interface homeNewsSummaryModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int code;

@property(nonatomic,strong)homeNewsInfoModel *infoModel;

@end



NS_ASSUME_NONNULL_END
